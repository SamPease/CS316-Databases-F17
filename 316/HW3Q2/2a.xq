<result>
  {
    for $i in /congress/people/person
    where starts-with($i/@name, 'Susan') or starts-with($i/@name, 'Suzan')
    return $i
  }
</result>