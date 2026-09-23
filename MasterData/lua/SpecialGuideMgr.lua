SpecialGuideMgr = MgrRegister("SpecialGuideMgr")
local this = SpecialGuideMgr;

function this:Init()
    self:Clear()
    self:InitListener()
end

function this:InitListener()
    self.eventMgr = ViewEvent.New()
    if CSAPI.IsADVRegional(3) then
        self.eventMgr:AddListener(EventType.Loading_Start,self.OnLoadingStart)
        self.eventMgr:AddListener(EventType.Loading_Complete,self.OnLoadingComplete)
        self.eventMgr:AddListener(EventType.Scene_Load_Start,self.OnSceneLoadStart)
    end
end

function this.OnSceneLoadStart()
    this.canApply = false
end

function this.OnLoadingStart()
    this.canApply = false
end

function this.OnLoadingComplete()
    this.canApply = true
    this:ApplyNext()
end

function this:PushData(data)
    self.datas = self.datas or {};
    table.insert(self.datas,data);
    -- self:ApplyNext();
end

function this:ApplyNext()
    if not self.datas or #self.datas == 0 then
        return
    end

    local data = table.remove(self.datas,1);
    if not data.parent or IsNil(data.parent.gameObject) then
        return
    end
    UIUtil:ShowSpecialGuide(data.parent, data.viewName, data.type, data.datas);
    FuncUtil:Call(self.ApplyNext,this,200)
end

function this:SetCurShow(id)
    self.showId = id or 0
end

function this:GetCurShow()
    return self.showId
end

function this:SetShow(id,b)
    self.showInfos[id] = b
end

function this:IsShow(id)
    return self.showInfos[id]
end

function this:IsClose()
    local dungeonData = DungeonMgr:GetDungeonData(g_SpecialGuideCondition)
    if dungeonData and dungeonData:IsPass() then
        return true
    end
    return false
end

function this:Clear()
    self.showInfos = {}
    self.showId = nil
    self.canApply = true
    self.datas = nil
    if self.eventMgr then
        self.eventMgr:ClearListener()
    end
    self.eventMgr = nil
end

function this:ApplyShowView(parent, viewName, type, datas)
    if CSAPI.IsADVRegional(3) then
        UIUtil:ShowSpecialGuide(parent, viewName, type, datas)
    end
end

return this