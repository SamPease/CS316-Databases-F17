<report>{
  for $i in doc("test.xml")//student
  let $j := sum($i/deed/@points)
  stable order by $i/@id
  return <student id="{$i/@id}" />
}</report>
