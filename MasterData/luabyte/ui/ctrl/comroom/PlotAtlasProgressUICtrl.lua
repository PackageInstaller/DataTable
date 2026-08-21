local M = BaseClass("PlotAtlasProgressUICtrl", BaseUICtrl)

function M:Init()
    -- 百科图鉴列表面板
    local itemCtrl = require("UI.Ctrl.ComRoom.PlotAtlasProgressItemCtrl")
    local itemView = require("UI.View.ComRoom.PlotAtlasProgressItemView")
    self.m_typeCfg = nil  -- bookReward数据
    self._unLockNum = 0
    self.m_bookGroup = {} -- 当前type所有book数据
    self._liveness = {}
    self.m_selectData = nil
    self._loopScroll = self._view.node_list
    self._loopScroll:Init(itemCtrl, itemView)
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._view.btn_info:onClick(Bind(self, self.OnShowBookInfo))
    self._loopScroll:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end

function M:OnEnter(data)
    self.m_typeCfg = data
    self._view.txt_title:SetText(self.m_typeCfg.name)
    PlotAtlasDataMgr:GetInstance():ChangeBookState(self.m_typeCfg.type, false)
    self:_InitBookList()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnClose()
    PlotAtlasDataMgr:GetInstance():CheckOffEncyclopediaRedPoint(self.m_typeCfg.type)
    IRedPointMgr:ForceCheck(RedPointConst.EncyclopediaByTypeRedPointChecker)
    self.m_selectData = nil
    self.m_bookGroup = nil
    self.m_typeCfg = nil
end

function M:_OnCreateItem(ctrl)
    ctrl:SetClickCallback(function(data)
        if self.m_selectData then
            self.m_selectData.IsSelect = false
        end
        self.m_selectData = data
        self.m_selectData.IsSelect = true
        self._loopScroll:UpdateList()
        self:_UpdateSelect()
    end)
end

function M:OnShowBookInfo()
    local list = {}
    for _, value in ipairs(self.m_bookGroup) do
        if value.IsUnlock then
            table.insert(list, value.Config)
        end
    end

    table.sort(list, function(a, b) return a.id < b.id end)

    local bookId = self.m_selectData.Config.id
    for i, value in ipairs(list) do
        if value.id == bookId then
            UIContextMgr:GetInstance():Show("PlotAtlasDrawPopup", list, i)
            break
        end
    end
end

-- 初始化列表
function M:_InitBookList()
    self.m_bookGroup = {}
    local bookType = self.m_typeCfg.type
    self._unLockNum = PlotAtlasDataMgr:GetInstance():GetPlotAtlasUnlockNum(bookType, self.m_bookGroup)
    -- 排序，Id小到大
    table.sort(self.m_bookGroup, function(a, b)
        return a.Config.id < b.Config.id
    end)

    self.m_selectData = self.m_bookGroup[1]
    if self.m_selectData then self.m_selectData.IsSelect = true end
    local totalNum = #self.m_bookGroup
    local numberStr = string.format("(%d/%d)", self._unLockNum, totalNum)
    self._view.txt_number:SetText(numberStr)
    self._loopScroll:SetDataList(self.m_bookGroup)
    self:_UpdateSelect()
end

function M:_UpdateSelect()
    local book = self.m_selectData.Config
    if self.m_selectData.IsUnlock then
        self._view.node_uiState:SetState(1)
        local descStr = ""
        for i = 1, #book.bookDesc4, 1 do
            local openId4 = book.openCondition4[i]
            if GameHelper.CheckLockByOpenConditionId(openId4) then
                local desc = ConfigHelper.GetLocalString(book.bookDesc4[i])
                descStr = descStr .. desc .. "\n"
            end
        end

        self._view.txt_desc:SetText(descStr)
        self._view.txt_cnName:SetText(book.bookDesc1[1])
        self._view.txt_enName:SetText(book.bookDesc1En[1] or book.bookDesc1[1] or 0)
        self._view.img_picture:SetColor(255, 255, 255, 255)
    else
        self._view.img_picture:SetColor(132, 132, 132, 184)
        self._view.node_uiState:SetState(2)
        local cfg = ConfigHelper.GetCfgByLua("openCondition", book.openCondition) or {}
        if cfg.tips then
            self._view.txt_cond:SetText(cfg.tips)
        else
            Logger.LogError("[openCondition] is nil, id = " .. book.openCondition)
        end
    end
    self._view.img_picture:SetPic(book.bigPicture, false)
end

return M
