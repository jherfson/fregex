module fexp

 implicit none

 character(len=10), parameter :: numbers = '1234567890'
 character(len=26), parameter :: lowercase = 'abcdefghijklmnopqrstuvwxyz'
 character(len=26), parameter :: uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
 character(len=2), parameter :: otherwords = '-_'

contains

 logical function match(regexp, text)

    character(len=*), intent(in) :: regexp
    character(len=*), intent(in) :: text

    integer :: pos

    if (regexp(1:1).eq."^") then
        match = matchhere(regexp(2:len(regexp)), text)
    else

        do pos = 1, len(text)
            if ( matchhere(regexp, text(pos:len(text))) ) then
                match = .true.
                exit
            endif
            match = .false.
        enddo
    endif

  end function match

  logical recursive function matchhere(regexp, text) result(res)

    character(len=*), intent(in) :: regexp
    character(len=*), intent(in) :: text
    
    integer :: classend 

    if (len(regexp).eq.0) then
        ! Assuming idiot input is protected by caller
        ! this is needed to simplify the other recursive functions.
        res = .true.
    elseif (len(regexp).eq.1) then 
        if (text(1:1).eq.regexp(1:1)) then
                res = .true.
        elseif (regexp(1:1).eq.".") then
                res = .true.
        elseif ((regexp(1:1).eq."$") &
                & .and.(len(text).eq.0)) then
                res = .true.
        else 
                res = .false.
        endif
    elseif (regexp(1:1).eq.'[') then
        classend = index(regexp(2:len(regexp)), ']')
        if (classend.eq.0) stop("No terminating char class")
        if (regexp(classend+2:classend+2).eq.'*') then
            res = starcharclar(regexp(2:classend), regexp(classend+3:len(regexp)), text)
        elseif (regexp(classend+2:classend+2).eq.'?') then
            res = onecharclass(regexp(2:classend), regexp(classend+3:len(regexp)), text)
        elseif (regexp(classend+2:classend+2).eq.'+') then
            res = matchhere('['//regexp(2:classend)//']['//regexp(2:classend)//']*'//regexp(classend+3:len(regexp)), text)
        else
            res = charclass(regexp(2:classend), regexp(classend+2:len(regexp)), text)
        endif
    elseif (regexp(1:1).eq.'\') then
        if (regexp(3:3).eq.'*') then
            if (regexp(2:2).eq.'w') then
                res = starcharclar(numbers//lowercase//uppercase//otherwords, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'d') then
                res = starcharclar(numbers, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'W') then
                res = starcharclar("^"//numbers//lowercase//uppercase//otherwords, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'D') then
                res = starcharclar("^"//numbers, regexp(4:len(regexp)), text)
            else
                res = litmatch(regexp(2:len(regexp)), text)
            endif
        elseif (regexp(3:3).eq.'?') then
            if (regexp(2:2).eq.'w') then
                res = onecharclass(numbers//lowercase//uppercase//otherwords, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'d') then
                res = onecharclass(numbers, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'W') then
                res = onecharclass("^"//numbers//lowercase//uppercase//otherwords, regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'D') then
                res = onecharclass("^"//numbers, regexp(4:len(regexp)), text)
            else
                res = litmatch(regexp(2:len(regexp)), text)
            endif
        elseif (regexp(3:3).eq.'+') then
            if (regexp(2:2).eq.'w') then
                res = matchhere('\w\w*'//regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'d') then
                res = matchhere('\d\d*'//regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'W') then
                res = matchhere('\W\W*'//regexp(4:len(regexp)), text)
            elseif (regexp(2:2).eq.'D') then
                res = matchhere('\D\D*'//regexp(4:len(regexp)), text)
            else
                res = litmatch(regexp(2:len(regexp)), text)
            endif
        else
            if (regexp(2:2).eq.'w') then
                res = charclass(numbers//lowercase//uppercase//otherwords, regexp(3:len(regexp)), text)
            elseif (regexp(2:2).eq.'d') then
                res = charclass(numbers, regexp(3:len(regexp)), text)
            elseif (regexp(2:2).eq.'W') then
                res = charclass("^"//numbers//lowercase//uppercase//otherwords, regexp(3:len(regexp)), text)
            elseif (regexp(2:2).eq.'D') then
                res = charclass("^"//numbers, regexp(3:len(regexp)), text)
            else
                res = litmatch(regexp(2:len(regexp)), text)
            endif
        endif
    elseif (regexp(2:2).eq."?") then
        res = onematch(regexp(1:1), & 
                     & regexp(3:len(regexp)), text)
    elseif (regexp(2:2).eq."*") then
        res = matchstar(regexp(1:1), & 
                     & regexp(3:len(regexp)), text)
    elseif (regexp(2:2).eq."+") then
        res = matchhere(regexp(1:1)//regexp(1:1)// & 
                     & '*'//regexp(3:len(regexp)), text)
    elseif (text(1:1).eq.regexp(1:1)) then
        res =  matchhere( regexp(2:len(regexp)), &
                     & text(2:len(text)) )
    elseif (regexp(1:1).eq.".") then
        res =  matchhere( regexp(2:len(regexp)), & 
                     &  text(2:len(text)) )
    else 
        res = .false.
    endif

  end function matchhere

  logical recursive function litmatch(regexp, text)

    character(len=*), intent(in) :: regexp
    character(len=*), intent(in) :: text
    ! FIXME - handle cases of *, ? and + -- without breaking the lit match.
    if (text(1:1).eq.regexp(1:1)) then
        litmatch =  matchhere( regexp(2:len(regexp)), &
                     & text(2:len(text)) )
    else
        litmatch = .false.
    endif

  end function litmatch

  logical recursive function onematch(onechar, regexp, text)

      character(len=1), intent(in) :: onechar
      character(len=*), intent(in) :: regexp
      character(len=*), intent(in) :: text

      if ((text(1:1).eq.onechar).or.(onechar.eq.'.')) then
         if (matchhere(regexp, text(2:len(text)))) then
            ! One of the char and the rest of the expression
            onematch = .true.
         else
            ! Backtrack to zero of the char and the expression
            onematch = matchhere(regexp, text)
         endif
      else
         ! Just the rest of the expression also OK
         onematch = matchhere(regexp, text)
      endif

  end function onematch

  logical recursive function matchstar(starchar, regexp, text) 

      character(len=1), intent(in) :: starchar
      character(len=*), intent(in) :: regexp
      character(len=*), intent(in) :: text

      integer :: pos
      
      pos = 1
      do 
          if (matchhere(regexp, text(pos:len(text)))) then
              matchstar = .true.
              exit
          elseif ((pos.le.len(text)) &
                  & .and. ( &
                  &    (text(pos:pos).eq.starchar) & 
                  &    .or.(starchar.eq.".") & 
                  & )) then
              pos = pos+1
          else
              matchstar = .false.
              exit
          endif
      enddo


  end function matchstar

  logical recursive function charclass(class, regexp, text)

      character(len=*), intent(in) :: class
      character(len=*), intent(in) :: regexp ! after the class
      character(len=*), intent(in) :: text 

      logical :: negate 

      negate = .false.

      if (class(1:1).eq.'^') then 
         negate = .true.
      endif

      if ((len(class).lt.1).and..not.negate) stop ("Empty char class!") 
      if ((len(class).lt.2).and.negate) stop ("Empty char class!") 
  
      if (.not.negate) then
          if (scan(text(1:1),class).eq.1) then
              charclass = matchhere(regexp, text(2:len(text)))
          else
              charclass = .false.
          endif
      else
          if (scan(text(1:1),class(2:len(class))).eq.1) then
              charclass = .false.
          else
              charclass = matchhere(regexp, text(2:len(text)))
          endif
      endif

  end function charclass


  logical recursive function onecharclass(class, regexp, text)

      character(len=*), intent(in) :: class
      character(len=*), intent(in) :: regexp ! after the class
      character(len=*), intent(in) :: text 

      logical :: negate 

      negate = .false.

      if (class(1:1).eq.'^') then 
         negate = .true.
      endif

      if ((len(class).lt.1).and..not.negate) stop ("Empty char class!") 
      if ((len(class).lt.2).and.negate) stop ("Empty char class!") 
  
      if (.not.negate) then
          ! not negated
          if (scan(text(1:1),class).eq.1) then
             if (matchhere(regexp, text(2:len(text)))) then
                ! One of the char and the rest of the expression
                onecharclass = .true.
             else
                ! Backtrack to zero of the char and the expression
                onecharclass = matchhere(regexp, text)
             endif
          else
             ! Just the rest of the expression also OK
             onecharclass = matchhere(regexp, text)
          endif
      else
          ! Negated
          if (scan(text(1:1),class(2:len(class))).eq.1) then
             ! OK if the whole of the rest of the regexp matched everything...
             onecharclass = matchhere(regexp, text)
          else
             if (matchhere(regexp, text(2:len(text)))) then
                ! Not one of the char and the rest of the expression - OK
                onecharclass = .true.
             else
                ! Backtrack to zero of the char and the expression
                onecharclass = matchhere(regexp, text)
             endif
          endif
      endif

  end function onecharclass

  logical recursive function starcharclar(class, regexp, text)

      character(len=*), intent(in) :: class
      character(len=*), intent(in) :: regexp ! after the class
      character(len=*), intent(in) :: text 

      logical :: negate
      integer :: pos

      negate = .false.

      if (class(1:1).eq.'^') then 
         negate = .true.
      endif

      if ((len(class).lt.1).and..not.negate) stop ("Empty char class!") 
      if ((len(class).lt.2).and.negate) stop ("Empty char class!") 
  
      
      pos = 1
      do 
          if (matchhere(regexp, text(pos:len(text)))) then
              starcharclar = .true.
              exit
          elseif ((pos.le.len(text)) &
                  & .and.(.not.negate).and. ( &
                  &    (scan(text(1:1),class).eq.1) & 
                  & )) then
              pos = pos+1
          elseif ((pos.le.len(text)) &
                  & .and.negate.and. ( &
                  &    (scan(text(1:1),class(2:len(class))).eq.0) & 
                  & )) then
              pos = pos+1
          else
              starcharclar = .false.
              exit
          endif
      enddo

  end function starcharclar

end module fexp
