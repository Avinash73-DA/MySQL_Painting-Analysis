# MySQL_Painting-Analysis

Are there museums without any paintings?

select * from museum m
	where not exists (select * from work w
					 where w.museum_id=m.museum_id)

![image](https://github.com/user-attachments/assets/a1675aff-71ea-48cd-a22b-7385cd9bc570)
