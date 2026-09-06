local BM_GotoDialog = class("BM_GotoDialog")
local CDeepLink = BeanManager.GetTableByName("activity.cdeeplink")
local ResourceDungeonInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeoninfo")

function BM_GotoDialog:Ctor()
end

function BM_GotoDialog:HandleGoto(targetstr)
  LogInfoFormat("BM_GotoDialog", "HandleGoto target = %s", targetstr)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  local targetid = ""
  local parm = ""
  local list = string.split(targetstr, "_")
  if list and list[1] and list[1] ~= "" then
    targetid = list[1]
    parm = list[2] or ""
  else
    LogInfoFormat("BM_GotoDialog", "HandleGoto error ")
    return
  end
  if targetid == "welfare" then
    if not controller then
      return
    end
    BM_GotoDialog:HandleGotoWelfare(parm)
  elseif targetid == "gacha" then
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    local id = tonumber(parm) or 1
    for _, v in pairs(NekoData.BehaviorManager.BM_Gacha:GetGachaPools()) do
      if v.id == id then
        local dlg = DialogManager.CreateSingletonDialog("gacha.gachamaindialog")
        if dlg then
          dlg:Init(SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base))
          dlg:OnPoolCellClick({id = id})
        end
      end
    end
  elseif targetid == "worldboss" then
    if not controller then
      return
    end
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:Init(controller)
      dialog:OpenBossRushPanel()
    end
  elseif targetid == "resourceskill" then
    if not controller then
      return
    end
    BM_GotoDialog:HandleGotoResource(301)
  elseif targetid == "resourcebreak" then
    if not controller then
      return
    end
    BM_GotoDialog:HandleGotoResource(201)
  elseif targetid == "resourcemana" then
    if not controller then
      return
    end
    BM_GotoDialog:HandleGotoResource(101)
  elseif targetid == "resourceequip" then
    if not controller then
      return
    end
    BM_GotoDialog:HandleGotoResource(401)
  elseif targetid == "fragment" then
    if not controller then
      return
    end
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Fragment) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:Init(controller)
      dialog:ItemTipsJump({
        gainType = DataCommon.GainTypeEnum.Fragment,
        worldId = nil
      })
    end
  elseif targetid == "undecidedroad" then
    if not controller then
      return
    end
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UndecidedRoad) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:Init(controller)
      dialog:ItemTipsJump({
        gainType = DataCommon.GainTypeEnum.UndecidedRoad,
        worldId = nil
      })
    end
  elseif targetid == "seasonpvp" then
    if not controller then
      return
    end
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:Init(controller)
      dialog:ItemTipsJump({
        gainType = DataCommon.GainTypeEnum.SeasonPVP,
        worldId = nil
      })
    end
  elseif targetid == "familyboss" then
    if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild) then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
      return
    end
    NekoData.DataManager.DM_Guild:GotoGuildBossJump()
  end
end

function BM_GotoDialog:HandleGotoWelfare(parm)
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Welfare) then
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
    return false
  end
  local flag = false
  if parm == "1" and NekoData.BehaviorManager.BM_SevenGrow:GetSevenDaysIsOpen() then
    flag = true
  elseif parm == "2" and NekoData.BehaviorManager.BM_Welfare:ShowWelfareEntrance_GrowGift() then
    flag = true
  elseif parm == "3" and NekoData.BehaviorManager.BM_Welfare:IsWitchCalendarOpen() then
    flag = true
  elseif parm == "4" and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):ShowWelfareEntrance_Sign() then
    flag = true
  elseif parm == "5" and NekoData.BehaviorManager.BM_Welfare:IsMonthSignOpen() then
    flag = true
  elseif parm == "6" and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):GetCurrentActId() > 0 then
    flag = true
  end
  if flag then
    local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
    if dialog then
      dialog:SetData(true)
      if parm == "1" then
        dialog:SetSelectedTab(dialog.WelfareType.sevenGrow)
      elseif parm == "2" then
        dialog:SetSelectedTab(dialog.WelfareType.growGift)
      elseif parm == "3" then
        dialog:SetSelectedTab(dialog.WelfareType.witchCalendar)
      elseif parm == "4" then
        dialog:SetSignInTab()
      elseif parm == "5" then
        dialog:SetSelectedTab(dialog.WelfareType.monthSign)
      elseif parm == "6" then
        dialog:SetSelectedTab(dialog.WelfareType.dreamSpiral)
      end
    end
  else
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
  end
end

function BM_GotoDialog:HandleGotoResource(resourceid)
  local _worldId = 0
  local _record = ResourceDungeonInfoTable:GetRecorder(resourceid)
  if _record == nil then
    LogErrorFormat("BM_GotoDialog", "cant find resource info by id %s", resourceid)
    return
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Resource) then
    local resourcePanelList = NekoData.BehaviorManager.BM_Game:GetResourcePanelList()
    for i, v in ipairs(resourcePanelList) do
      if v.id == _record.typeID and not v.lock and v.open then
        local littleTypeInfo = v.detailInfo[_record.sortID]
        if littleTypeInfo and littleTypeInfo.open then
          _worldId = v.id
          break
        end
      end
    end
  end
  if _worldId == 0 then
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(700921))
    LogErrorFormat("BM_GotoDialog", "cant find world info by id %s", resourceid)
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
  if dialog then
    local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    dialog:Init(sceneController)
    dialog:ItemTipsJump({
      gainType = DataCommon.GainTypeEnum.Resource_NotSelect,
      worldId = _worldId,
      info = _record
    })
  end
end

function BM_GotoDialog:HandleDeepLink(deeplinkStr)
  NekoData.BehaviorManager.BM_GotoDialog:HandleGoto(deeplinkStr)
  if CS.PixelNeko.P1.DeepLink.ClearDeeplinkJsonString then
    CS.PixelNeko.P1.DeepLink.ClearDeeplinkJsonString()
  end
  CS.PixelNeko.P1.DeepLink.SetInfo("")
  local str = CS.PixelNeko.P1.DeepLink.GetInfo()
  LogInfoFormat("DeepLinkFSM", "after clear deeplinkStr = %s", str)
end

return BM_GotoDialog
