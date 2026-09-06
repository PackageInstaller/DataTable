_G.stringutils = {}

function stringutils.split2table(s)
  local t = {}
  local tag_end = 8
  local findCIdx = 0
  local c_begin, c_end = false, false
  local i, j = 0, 0
  local c_begin_end
  for p, c in utf8.codes(s) do
    c = utf8.char(c)
    if c == "<" and (string.sub(s, p + 1, p + 7) == "color=#" and findCIdx % 2 == 0 or string.sub(s, p, p + 7) == "</color>") then
      if string.sub(s, p + 1, p + 7) == "color=#" and findCIdx % 2 == 0 then
        c_begin = true
        lasti = i
        i = p
        findCIdx = findCIdx + 1
      elseif string.sub(s, p, p + 7) == "</color>" then
        c_end = true
        j = p
      end
    elseif c_begin then
      if not c_end then
        if not c_begin_end and c == ">" then
          c_begin_end = p - i + 1
        end
        if c_begin_end and p > i + c_begin_end - 1 and not c_end then
          local temp = string.sub(s, i, i + c_begin_end - 1)
          temp = temp .. c .. "</color>"
          table.insert(t, temp)
        end
      elseif j + tag_end - 1 == p then
        c_begin = false
        c_begin_end = nil
        c_end = false
      end
    else
      table.insert(t, c)
    end
  end
  return t
end
