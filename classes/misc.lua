function tableLength(Table)
  local count = 0
  for k, v in pairs(Table) do if(v ~= nil and k~= nil) then count = count + 1 end end
  return count
end
