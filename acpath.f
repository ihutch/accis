c**************************************************************************
c Dummy acpathdoc must be replaced by explicitly linked version if
c path documentation is actually desired.
      subroutine acpathdoc(z,cv,l,imax,xc,yc,i)
      real xc,yc,cv
      integer l,imax,i
      real z(*)
c API: at each succeeding contour position i (1 to N), 
c     acpathdoc is called with arguments
c     z(l,*) the array being contoured at contour value cv
c     imax (in) has value of the last argument of confol (length of xc,yc)
c          or an end indicator: -1 exhausted, -2 initial pt, -3 reached edge
c     xc, yc, i, the position of point i in path arrays.
c Typical usage might be to declare the new acpathdoc to have a common
c block into which xc,yc are entered to provide the contour as a polyline
c xpath(i)=xc; ypath(i)=yc. 
      end
