<result>
  {
    for $i in //people
	return(
		element Democrat{
			element M {
				attribute count {count(//person[@gender="M"]/role[@current=1][@party="Democrat"])}},
			element F {
				attribute count {count(//person[@gender="F"]/role[@current=1][@party="Democrat"])}}
		},
		element Republican{
			element M {
				attribute count {count(//person[@gender="M"]/role[@current=1][@party="Republican"])}},
			element F {
				attribute count {count(//person[@gender="F"]/role[@current=1][@party="Republican"])}}
		},
		element Independent{
			element M {
				attribute count {count(//person[@gender="M"]/role[@current=1][@party="Independent"])}},
			element F {
				attribute count {count(//person[@gender="F"]/role[@current=1][@party="Independent"])}}
		}
	)			
  }
</result>