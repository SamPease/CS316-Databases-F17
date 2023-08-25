<result>
  {
    for $i in //person
	where $i/role/@startdate < xs:date("1980-01-01") and $i/role[@current=1]/@type="sen"
    return <senator name="{$i/@name}"/>
  }
</result>