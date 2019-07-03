c Do a plot and convert the output to svg.
c
c Various working variables.
      integer length
      parameter (length=100)
      real x(length),y(length),err(length),ym(length)
      integer i,irows,icolumns,itype
      character*150 string

c Make test arrays.
      do 2 i=1,length
	 x(i)=float(i)*1.
	 y(i)=1.*(1.4+sin(0.2*x(i)))
	 err(i)=0.4*sin(x(i)*sin(x(i)))
	 ym(i)=y(i)-0.5*err(i)
    2 continue
      string='(''FILE='',a8,'';epstopdf ${FILE}.ps; if pdf2svg '//
     $     '${FILE}.pdf ${FILE}.svg; then rm ${FILE}.ps ${FILE}.pdf'//
     $     ';fi;'')'
      write(*,*)'For the first plot the bash command is'
      write(*,string)'plot0001.ps'
      call pfset(3)
c pltsvg only works on eps file output at the moment.
      call autoplot(x,y,length)
c      call pltend()
      call pltsvg
      end
