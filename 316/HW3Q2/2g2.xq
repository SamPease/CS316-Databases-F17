<result>
  {
    for $i in //people
	let $a := distinct-values(//role[curremt="1"]/@party)
	return element {$a}{
			attribute name {$i/person[position()=1]/@name}
			}
				
  }
</result>