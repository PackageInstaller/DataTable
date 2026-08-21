local roleBtn = {}
roleBtn.__index = roleBtn
local vec3 = require("base.vec3")
local ids = {
  atk = 15,
  dash = 18,
  sk1 = 19,
  sk2 = 20,
  ult = 62
}
local id2s = {
  atk = 1,
  dash = 3,
  sk1 = 4,
  sk2 = 5,
  ult = 7
}
local enhanceMagics = {
  atk = Const.BTN_MAGICS.ENHANCE.ATK,
  dash = Const.BTN_MAGICS.ENHANCE.DASH,
  sk1 = Const.BTN_MAGICS.ENHANCE.SK1,
  sk2 = Const.BTN_MAGICS.ENHANCE.SK2
}
local shakeMagics = {
  sk1 = Const.BTN_MAGICS.SHAKE.SK1,
  sk2 = Const.BTN_MAGICS.SHAKE.SK2,
  dash = Const.BTN_MAGICS.SHAKE.DASH,
  ult = Const.BTN_MAGICS.SHAKE.ULT,
  atk = Const.BTN_MAGICS.SHAKE.ATK
}

function roleBtn.new(base, role, _cfg)
  local result = setmetatable({}, base)
  result.base = base
  result.role = role
  result.tool = role.tool
  result.inputor = role.inputor
  result.indiMgr = role.indiMgr
  result._indiPos = vec3.New()
  local cfg = _cfg or {}
  result.name = base.BUTTON_TYPE[cfg.BtnName]
  result.id = ids[result.name]
  result.id2 = id2s[result.name]
  result.enhanceBlink = enhanceMagics[result.name]
  result.shake = shakeMagics[result.name]
  result.enhanceLoopFx = "Strengthen_skill_"
  result.cdCompleteFx = "Charge_skill_"
  result:clearUiCfg()
  result.uiCfg = {}
  result.icon = role.icons[cfg.InitIcon]
  result.isDown = false
  result.holdTimer = 0
  result.isHolding = false
  result.drawEnable = result.drawEnableInPlace
  return result
end

roleBtn.BUTTON_TYPE = Const.BUTTON_TYPE

function roleBtn.insertFun(btn, funName, newFun)
  btn.tool.insert(btn, funName, newFun)
end

function roleBtn.removeFun(btn, funName, newFun)
  btn.tool.remove(btn, funName, newFun)
end

function roleBtn.clearUiCfg(btn)
  btn.isEnable = nil
  btn.isEnhance = nil
  btn.ringYellow = {
    isOn = nil,
    type = nil,
    attr = {curAttrId = nil, maxAttrId = nil},
    magic = {id = nil, isReduce = nil}
  }
  btn.waterLine = {
    isOn = nil,
    type = nil,
    attr = {curAttrId = nil, maxAttrId = nil},
    magic = {id = nil, isReduce = nil}
  }
  btn.charge = {
    isOn = nil,
    type = nil,
    res = nil,
    attr = {curAttrId = nil, maxAttrId = nil},
    magic = {id = nil, isReduce = nil}
  }
  btn.indicator = {
    isOn = nil,
    sensi = nil,
    area = {
      type = nil,
      res = nil,
      sizex = nil
    },
    indi = {
      type = nil,
      res = nil,
      sizex = nil,
      sizey = nil
    }
  }
end

function roleBtn.down(btn)
  btn.isDown = true
  local icon = btn.icon
  local role = btn.role
  if not icon.isEnable then
    cast_magic(role.npc, role.npc, btn.shake)
  end
  icon:btnDown(btn)
end

function roleBtn.up(btn)
  btn.isDown = false
  btn.icon:btnUp(btn)
end

function roleBtn.cancelUp(btn)
  btn.isDown = false
  btn.icon:btnCancelUp(btn)
end

function roleBtn.drawEnableWithChange(btn)
  local icon = btn.icon
  local newIsEnable = icon.isEnable
  if btn.isEnable == newIsEnable then
    return
  end
  if newIsEnable then
    play_ui_fight_button_effect({
      "gray",
      nil,
      btn.icon.skill.id,
      0,
      0
    })
  else
    play_ui_fight_button_effect({
      "gray",
      nil,
      btn.icon.skill.id,
      1,
      0
    })
  end
  btn.isEnable = icon.isEnable
end

function roleBtn.drawEnableInPlace(btn)
  local icon = btn.icon
  local newIsEnable = icon.isEnable
  if btn.isEnable == newIsEnable then
    return
  end
  if newIsEnable then
    play_ui_fight_button_effect({
      "gray",
      nil,
      btn.icon.skill.id,
      0,
      0
    })
    play_ui_fight_button_effect({
      btn.cdCompleteFx,
      btn.id2
    })
  else
    play_ui_fight_button_effect({
      "gray",
      nil,
      btn.icon.skill.id,
      1,
      0
    })
  end
  btn.isEnable = icon.isEnable
end

function roleBtn.drawEnhance(btn)
  local icon = btn.icon
  if btn.isEnhance == icon.isEnhance then
    return
  end
  local str = btn.enhanceLoopFx
  if icon.isEnhance then
    local role = btn.role
    cast_magic(role.npc, role.npc, btn.enhanceBlink)
    play_ui_fight_button_effect({
      str,
      btn.id2
    })
  else
    stop_ui_fight_button_effect({
      str,
      btn.id2
    })
  end
  btn.isEnhance = icon.isEnhance
end

function roleBtn.drawCharge(btn)
  local old = btn.charge
  local icon = btn.icon
  local new = icon.charge
  local reboot = false
  if new.isOn ~= old.isOn then
    if new.isOn == false then
      clear_skill_btn_charging(btn.id)
      btn.charge.isOn = false
      return
    else
      reboot = true
    end
  elseif new.isOn == true then
    if new.type ~= old.type or new.res ~= old.res then
      reboot = true
    else
      local res = new.res
      if new[res] then
        for keyName, newValue in pairs(new[res]) do
          if newValue ~= old[res][keyName] then
            reboot = true
            break
          end
        end
      end
    end
  end
  if reboot then
    local type = new.type == "ring" and 2 or 1
    local res = new.res
    local cfg = btn.uiCfg
    if "attr" == res then
      cfg.param_type = 1
      cfg.param1 = new.attr.curAttrId
      cfg.param2 = new.attr.maxAttrId
    elseif "magic" == res then
      cfg.param_type = 3
      cfg.param1 = btn.role.npc
      cfg.param2 = new.magic.id
      cfg.param3 = new.magic.isReduce
    end
    set_skill_btn_charging(btn.id, type, cfg)
    btn.charge.isOn = new.isOn
    btn.charge.type = new.type
    btn.charge.res = new.res
    if new[res] then
      for keyName, newValue in pairs(new[res]) do
        btn.charge[res][keyName] = newValue
      end
    end
  end
end

function roleBtn.draw(btn)
  btn:drawEnable()
  btn:drawEnhance()
  btn:drawCharge()
end

function roleBtn.tick(btn)
  btn.icon:tick()
  btn:draw()
end

function roleBtn.setIcon(btn, tarIcon, maskTime)
  if btn.role_base_icon then
    btn.custom_icon = tarIcon
    return
  end
  btn:doSetIcon(tarIcon, maskTime)
end

function roleBtn.doSetIcon(btn, tarIcon, maskTime)
  local role = btn.role
  local oldIcon = btn.icon
  if tarIcon == oldIcon then
    return
  end
  local mgr = btn.indiMgr
  local oldIndi = mgr.indi
  local oldIndiActive = oldIndi and oldIndi.btn.id == btn.id
  local setIconLocks = btn.role.tool.setIconLocks
  setIconLocks[btn.name] = oldIndiActive
  if oldIcon then
    oldIcon:btnOff(btn)
  end
  btn.icon = tarIcon
  replace_hero_skill(btn.id2, tarIcon.skill.id)
  tarIcon:btnOn(btn, maskTime)
  local newIndi = mgr.indi
  local newIndiActive = newIndi and newIndi.btn.id == btn.id and newIndi ~= oldIndi
  if newIndiActive then
    btn.indi = newIndi
  else
    btn.indi = nil
  end
  if oldIndiActive and not newIndiActive then
    mgr:pop()
  end
  setIconLocks[btn.name] = false
  if role:isInControl() then
    btn:clearUiCfg()
    btn.drawEnable = btn.drawEnableWithChange
    btn:tick()
    btn.drawEnable = btn.drawEnableInPlace
  else
    btn.icon:tick()
  end
end

function roleBtn.set_icon_by_role_base(btn, tarIcon, maskTime)
  if not tarIcon then
    return btn:recover_custom_icon()
  end
  btn.role_base_icon = tarIcon
  btn.custom_icon = btn.custom_icon or btn.icon
  btn:doSetIcon(tarIcon)
end

function roleBtn.recover_custom_icon(btn)
  if not btn.role_base_icon then
    return
  end
  local custom_icon = btn.custom_icon
  btn.role_base_icon = nil
  btn.custom_icon = nil
  return btn:doSetIcon(custom_icon)
end

function roleBtn.isDrag(btn)
  return get_button_drag_state(btn.id2)
end

function roleBtn.indiPos(btn)
  local pos = btn._indiPos
  local x, z = get_indicator_pos(btn.id)
  pos.x = x or 0
  pos.z = z or 0
  pos.y = btn.role.npc:get_pos_vec3().y
  return pos
end

return roleBtn
