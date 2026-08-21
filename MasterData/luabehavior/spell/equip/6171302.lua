local M = Util.create_class()
local tool = import("common.tool")
local roleTool = import("common.role_tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  print(is_showup)
  if not is_showup then
    return
  end
  local last_role = roleTool.lastRole.npc
  if npc == self.npc then
    self.card_state = 1
  elseif last_role == self.npc then
    self.card_state = 0
    if check_magic(self.npc, 617130210) or check_magic(self.npc, 617130211) or check_magic(self.npc, 617130212) then
      for i = 1, 3 do
        for k, get_card_id in ipairs(self.get_card_list[i]) do
          if check_magic(self.npc, get_card_id) then
            cast_missile3(self.npc, nil, nil, nil, self.butterfly_missile[i][k])
            tool:abortMagicToTeam(get_card_id)
          end
        end
      end
    else
      for i = 1, 2 do
        for k = 1, 3 do
          abort_magic_by_id(self.npc, self.get_card_list[i][k])
        end
      end
    end
  end
end

function M:on_start()
  self.last_time = 0
  self.cd = 6
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  self.get_card_list = {
    [1] = {
      61713024,
      61713025,
      61713026
    },
    [2] = {
      61713027,
      61713028,
      61713029
    },
    [3] = {
      617130210,
      617130211,
      617130212
    }
  }
  self.card_state = 0
  self.butterfly_missile = {
    [1] = {
      61713910501,
      61713910502,
      61713910503
    },
    [2] = {
      61713910504,
      61713910505,
      61713910506
    },
    [3] = {
      61713910507,
      61713910508,
      61713910509
    }
  }
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= get_come_on_hero() then
    return
  end
  if 0 == self.card_state then
    return
  end
  if act:isSkillInput() then
    print("蓝牌", self.card_state)
    cast_magic(self.npc, self.npc, self.get_card_list[self.card_state][1])
  elseif act:isDashInput() then
    print("黄牌", self.card_state)
    cast_magic(self.npc, self.npc, self.get_card_list[self.card_state][2])
  elseif act:isAtkInput() then
    print("红牌", self.card_state)
    cast_magic(self.npc, self.npc, self.get_card_list[self.card_state][3])
  else
    return
  end
  self.card_state = self.card_state + 1
  if self.card_state > 3 then
    self.card_state = 0
  end
end

return M
