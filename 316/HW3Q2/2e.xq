<result>
  {
    for $i in //person
	where not ($i/@id =  //committees//member/@id)
    return <person>{$i/@name}</person>
  }
</result>