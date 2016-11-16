function tableLength(Table)
  local count = 0
  for _ in pairs(Table) do count = count + 1 end
  return count
end
