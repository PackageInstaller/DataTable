-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/utils/stringutils.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
-- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

_G.stringutils = {}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

stringutils.split2table = function(s)
  -- function num : 0_0 , upvalues : _ENV
  local t = {}
  local tag_end = 8
  local findCIdx = 0
  local c_begin, c_end = false, false
  local i, j = 0, 0
  local c_begin_end = nil
  for p,c in (utf8.codes)(s) do
    c = (utf8.char)(c)
    if ((string.sub)(s, p + 1, p + 7) == "color=#" and findCIdx % 2 == 0) or (string.sub)(s, p, p + 7) == "</color>" then
      if (string.sub)(s, p + 1, p + 7) == "color=#" and findCIdx % 2 == 0 then
        c_begin = true
        lasti = i
        i = p
        findCIdx = findCIdx + 1
      else
        if (string.sub)(s, p, p + 7) == "</color>" then
          c_end = true
          j = p
        end
      end
    else
      if c_begin then
        if not c_end then
          if not c_begin_end and c == ">" then
            c_begin_end = p - i + 1
          end
          if c_begin_end and i + (c_begin_end) - 1 < p and not c_end then
            local temp = (string.sub)(s, i, i + (c_begin_end) - 1)
            temp = temp .. c .. "</color>"
            ;
            (table.insert)(t, temp)
          end
        else
          do
            do
              if j + tag_end - 1 == p then
                c_begin = false
                c_begin_end = nil
                c_end = false
              end
              ;
              (table.insert)(t, c)
              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC114: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  return t
end


