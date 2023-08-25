<result>
  {
    for $i in //person,
		$a in $i/role[@current=1 and @state="NC" and @type="rep"]
	stable order by number($a/@district) ascending
    return <representative name="{$i/@name}" district="{$a/@district}" party="{$a/@party}"/>
  }
</result>