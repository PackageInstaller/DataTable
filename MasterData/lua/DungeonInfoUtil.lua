local this = {};

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:Set(cfg)
    self.panel = self.panel or {}
    self.create = self.create or {}
    if type(cfg) ~= "table" then
        self.datas = {}
        return
    end
    self.cfg = cfg
    if cfg then
        self.data = DungeonMgr:GetDungeonData(cfg.id)
        self.sectionData = DungeonMgr:GetSectionData(cfg.group)
    end
    self.datas = {cfg =self.cfg,data =self.data,sectionData =self.sectionData}
end

function this:Show(typeName,parent,path,callback)
    if not parent then
        LogError("未传入父物体！！！")
        return
    end

    if typeName == nil or typeName=="" then
        LogError("未传入组件名！！！")
        return
    end

    if self.panel[typeName] then
        CSAPI.SetGOActive(self.panel[typeName].gameObject, true)
        if self.panel[typeName].Refresh then
            self.panel[typeName].Refresh(self.datas)
        end
        if callback then
            callback(self.panel[typeName])
        end
        self.panel[typeName].transform:SetSiblingIndex(parent.transform.childCount - 1)
    else
        if self.create[typeName] then
            return
        end
        self.create[typeName] = true
        if typeName == "Double" or typeName == "Double2" then
            path = "DungeonItemInfo"
        end
        ResUtil:CreateUIGOAsync(path .. "/DungeonInfo" .. typeName,parent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            if lua.Refresh then
                lua.Refresh(self.datas)
            end
            self.panel[typeName] = lua
            if callback then
                callback(self.panel[typeName])
            end
        end)
    end
end

function this:Hidden(typeName)
    if typeName ~= nil and typeName ~= "" and self.panel[typeName] then
        CSAPI.SetGOActive(self.panel[typeName], false)
    else
        for _, lua in pairs(self.panel) do
            CSAPI.SetGOActive(lua.gameObject, false)
        end
    end
end

function this:ShowPanels(typeNames)
    self:Hidden()
    if typeNames and #typeNames > 0 then
        for _, typeName in ipairs(typeNames) do
            if self.panel[typeName] then
                CSAPI.SetGOActive(self.panel[typeName], true)
            end
        end
    end
end

function this:GetPanel(typeName)
    if self.panel and self.panel[typeName] and self.panel[typeName].gameObject.activeSelf == true then
        return self.panel[typeName]
    end
end

function this:GetPanels()
    return self.panel
end

function this:RefreshPanel()
    if self.panel then
        for _, lua in pairs(self.panel) do
            if not IsNil(lua.gameObject) and lua.gameObject.activeSelf then
                lua.Refresh(self.datas)
            end
        end
    end
end

return this