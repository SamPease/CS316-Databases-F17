<congress>
	<house>{
		for $a in //role[@current=1][@type="rep"]
		return(
		<person name="{$a/../@name}">{ 	
			for $b in //committee/member[@id=$a/../@id]
			return(if ($b/@role!="")
				then 
					<committee name="{$b/../@displayname}" role="{$b/@role}">{
					for $c in $b/../subcommittee/member[@id=$b/../@id]
					return(if ($c/@role!="")
						then
							<subcommittee name="{$c/../@displayname}" role="{$c/@role}"/>
						else(<subcommittee name="{$c/../@displayname}" role="Member"/>
						)
					)
					}</committee>
				else(					
					<committee name="{$b/../@displayname}" role="Member">{
					for $c in $b/../subcommittee/member[@id=$a/../@id]
					return(if ($c/@role!="")
						then
							<subcommittee name="{$c/../@displayname}" role="{$c/@role}"/>
						else(<subcommittee name="{$c/../@displayname}" role="Member"/>
						)
					)
					}</committee>
				)
			)
		}</person>
		)
	}</house>
	 <senate>{
		for $d in //role[@current=1][@type="sen"]
		return(
		<person name="{$d/../@name}">{ 	
			for $e in //committee/member[@id=$d/../@id]
			return(if ($e/@role!="")
				then 
					<committee name="{$e/../@displayname}" role="{$e/@role}">{
					for $f in $e/../subcommittee/member[@id=$d/../@id]
					return(if ($f/@role!="")
						then
							<subcommittee name="{$f/../@displayname}" role="{$f/@role}"/>
						else(<subcommittee name="{$f/../@displayname}" role="Member"/>
						)
					)
					}</committee>
				else(					
					<committee name="{$e/../@displayname}" role="Member">{
					for $f in $e/../subcommittee/member[@id=$d/../@id]
					return(if ($f/@role!="")
						then
							<subcommittee name="{$f/../@displayname}" role="{$f/@role}"/>
						else(<subcommittee name="{$f/../@displayname}" role="Member"/>
						)
					)
					}</committee>
				)
			)
		}</person>
		)	
	}</senate>  
</congress>