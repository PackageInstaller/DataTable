---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/11 17:09
---

local BlackListLogic = {};
local this = BlackListLogic;

local blackListPfbName = "BlackListItem"

local function OnClickRelieveButton(self,Id, name)
    self.friendComponent:OnClickRelieveButton(Id, name, function ()
        this.Init(self);
    end)
end

function this.InitContent(self,addFriends)
    ListChildPool:GetInstance():ClearContent(self.blackList_Content);
    self.hint:SetActive(table.count(addFriends) == 0)
    coroutine.start(function ()
        for k,v in table.pairsByKeys(addFriends) do
            ListChildPool:GetInstance():GetChild(blackListPfbName,self.blackList_Content,function(object)
                if self.active == false then ListChildPool:GetInstance():Remove(object) return end
                local rc = object:GetComponent("ReferenceCollector");
                local avatar_Image = rc:GetObject("Avatar"):GetComponent("Image");
                local name_Text = rc:GetObject("Name"):GetComponent("Text")
                local level_Text = rc:GetObject("Level"):GetComponent("Text")
                
                local relieve_Btn = rc:GetObject("DeletButton")
                LangUtil.GetSpriteLang(136, function(sprite) relieve_Btn:GetComponent("Image").sprite = sprite end)
                UIUtil.SetPlayerIcon(avatar_Image,v.Icon)
                
                LangUtil.BindText(name_Text).text = v.Name
                LangUtil.BindText(level_Text).text = "LV."..(v.Level or "--")
                UIUtil.AddBtnEvent(relieve_Btn,function(go) OnClickRelieveButton(self,v.Id,v.Name) end)
                UIUtil.AddBtnEvent(avatar_Image.gameObject,function() UIUtil.OpenPlayerInfo(v) end)
            end)
        end
    end)
end

function this.Init(self)
    this.InitContent(self,self.friendComponent.BlackList)
end


return this;