;Randomly sample 100m USA CMS maxent biomass values versus Global maxent lorey's height


;all images should be registered with each other

cms_image = '/Volumes/wd_3t/usa/usa_100m/'
lorey_image = '/Volumes/wd_3t/usa/usa_100m/'
type_image = '/Volumes/wd_3t/usa/usa_100m/'

prob = 0.000001D  ;probably of a non-zero pixel being selected

out_file = '/Volumes/wd_3t/usa/usa_100m/lorey_agb_100m_pixel.csv'

xdim = 
ydim = 



cms_line = fltarr(xdim)
lorey_line = fltarr(xdim)
type_line = bytarr(xdim)
select_line = bytarr(xdim)

format = '(f6.3,",",f7.2,",",i3)'

openr, cms_lun, cms_image, /get_lun
openr, lorey_lun, lorey_image, /get_lun
openr, type_lun, type_image, /get_lun

openw, out_lun, out_file, /get_lun

print, out_lun, 'lorey,cms_agb,type'

for j=0ULL, ydim-1 do begin
	readu, cms_lun, cms_line
	readu, lorey_lun, lorey_line
	readu, type_lun, type_line

	select_line[*] = randomu(seed, xdim) lt prob

	index = where((cms_line gt 0) and (lorey_line gt 0) and select_line, count)
	if (count gt 0) then begin
		for i=0ULL, count-1 do begin
			print, out_lun, format=format, lorey_line[index[i]], cms_line[index[i]], type_line[index[i]]
		endfor
	endif

endfor

free_lun, cms_lun, lorey_lun, type_lun, out_lun

end


