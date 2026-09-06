local function func(guideFrame)
  local dialog = DialogManager.GetDialog("mainline.mainline.newmainlinefloordialog")
  
  local child
  if dialog and dialog._rootWindow then
    local autoGoTag = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AutoExplore)
    if autoGoTag then
      child = dialog._goBtn
    else
      child = dialog._goBtnCenter
    end
    if child then
      return {
        parent = child._uiObject,
        effectPos = {posX = 0, posY = 0}
      }
    end
  end
end

return func
