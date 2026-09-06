local function p1(protocol)
  local dialog = DialogManager.GetDialog("gacha.gachamaindialog")
  
  if dialog then
    dialog:OnDrawCardResult()
  end
  local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
  local bagType = protocol.bagtype
  if bagType == BagTypeEnum.EQUIPBAG then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(29, nil, function()
      DialogManager.CreateSingletonDialog("equip.bagdialog")
      local scenedlg = DialogManager.GetDialog("towerv2.scene.towerv2scenedialog")
      if scenedlg then
        EffectFactory.CreateJumpBackEffect(66):Run()
      end
    end, {}, function()
      DialogManager.CreateSingletonDialog("equip.bagdialog")
      local scenedlg = DialogManager.GetDialog("towerv2.scene.towerv2scenedialog")
      if scenedlg then
        EffectFactory.CreateJumpBackEffect(66):Run()
      end
    end, {})
  end
  DialogManager.DestroySingletonDialog("towerv2.towerv2shrinedialog")
  DialogManager.DestroySingletonDialog("towerv2.towerv2eventdialog")
end

local function p2(protocol, client)
end

return {p1, p2}
