c  Test of autocontour routine.
      integer nx,ny
      parameter (nx=100,ny=80)
      real z(nx,ny),x(nx,ny),y(nx,ny)

      s=30./nx
      do i=1,nx
	 do j=1,ny
	    x(i,j)=0.7*float(i-4)
	    y(i,j)=j-4
	    z(i,j)=sin(s*(x(i,j)-.3*y(i,j))/2.)*sin(s*y(i,j)/4.)
         enddo
      enddo
      call pfset(3)
      call autocontour(z,nx,nx,ny)
      call pltend()


      end

