local M = BaseClass("OpenChapterSelection", BaseJumpCommand)
M.uiName = "ChapterSelection"
local CS_UIFormsType = CS.GameX.UIFormsType
local NormalPage = CS_UIFormsType.Normal
local FixedPage = CS_UIFormsType.Fixed
local PopUpPage = CS_UIFormsType.PopUp

function M:Execute(args)
    local ctxMgr = UIContextMgr:GetInstance()
    --跳到此处，应该关闭所有的界面
    ctxMgr:CloseUIByType(NormalPage)
    ctxMgr:CloseUIByType(FixedPage)
    ctxMgr:CloseUIByType(PopUpPage)
    self:ShowUI(M.uiName, table.unpack(args))
    return true
end

return M
