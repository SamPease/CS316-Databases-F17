<result>
  {
    for $i in //person,
		$a in $i/role[@current=1]	
	where ($i/role[@party != $a/@party])
    return <member name="{$i/@name}">
		{$a}
		{$i/role[@party != $a/@party]}
	</member>
  }
</result>