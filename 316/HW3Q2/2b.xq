<result>
  {
    for $i in //person
	where //committee[@code='SSAS']/subcommittee[@displayname="Personnel"]/member[@role="Chairman"]/@id=$i/@id
    return $i
  }
</result>