---@class UserSharePanel : UserSharePanel_Generate
---##################### 【UserSharePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UserSharePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UserSharePanel = require "UserSharePanel_Generate"

function UserSharePanel:InitLogic(data)
    self.nowShowSpineObj = nil
    self.maxTxtWidth = 16
end

--function UserSharePanel:StartCreating(time)
--
--end

--function UserSharePanel:StartEnter(time)
--
--end

--function UserSharePanel:StartRemoving(time)
--
--end

--function UserSharePanel:StartExit(time)
--
--end

function UserSharePanel:OnOpen(data, initiative)
    self:setUserShareData()
end

--设置玩家分享信息
function UserSharePanel:setUserShareData()
    --设置头像
    self:setHeadIcon()
    --显示用户名
    self.userNameTxt.text.text = Me:getUserName()
    --显示UID
    self.userUIdTxt.text.text = "UID:" .. Me.uid
    --显示舰船数量
    self.shipCountTxt.text.text = tablex.size(ClientData:GetRoleList())
    local LevelMainMax = Me:getLevelMainMax()
    local levelconfig = Config.GetPveLevelInfo(LevelMainMax)
    --战役记录
    local name = DLuaUtil.SetOverLengthStrToEllipsis(levelconfig.nameKey, self.maxTxtWidth)
    self.mainBattleTxt.text.text = name
    --显示看板娘
    self:setPosterIcon()
    self.tiktokFriendBtn.gameObject:SetActive(true)
    --iOS 不支持抖音好友分享，隐藏对应按钮
    if EngineGlobal.GetPlatformName() == "iOS" then
        self.tiktokFriendBtn.gameObject:SetActive(false)
    end
end

--设置头像
function UserSharePanel:setHeadIcon()
    local HeadConfig = Config.GetHeadportraitInfo(Me.head)
    if HeadConfig == nil then
        HeadConfig = Config.GetHeadportraitInfo(1000001)
    end
    local resourceFolder = nil
    if tonumber(HeadConfig.folder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(HeadConfig.folder)))
    else
        resourceFolder = HeadConfig.folder
    end
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, HeadConfig.filename), function (s)
        self.headIconImg.image.sprite = s
        self.headIconImg.canvasGroup.alpha = 1
    end)
end

--显示看板娘
function UserSharePanel:setPosterIcon()
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, ClientData:GetPosterData().SkinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
        self.nowShowSpineObj.transform.sizeDelta = Vector2.New(100, 5000)
        self.nowShowSpineObj.transform.localScale = Vector3.one * 0.6
        self.showCharacter.transform.localPosition = Vector3.New(0, self.showCharacter.transform.localPosition.y * 0.6, 0)
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        objSpine.freeze = true
    end)
end

--function UserSharePanel:OnClose(initiative)
--
--end

--function UserSharePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UserSharePanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function UserSharePanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:closeSpecificUI(self)
end

--[[
/ShareGroup/WeiBoBtn onClick 
--]]
function UserSharePanel:weiBoBtn_ScaleButton_onClick(weiBoBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "sina", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("微博分享结果", plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )

    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/ShareGroup/WeChatBtn onClick 
--]]
function UserSharePanel:weChatBtn_ScaleButton_onClick(weChatBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "weixin", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("微信分享结果", plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )

    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/ShareGroup/TapTapBtn onClick 
--]]
function UserSharePanel:tapTapBtn_ScaleButton_onClick(tapTapBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "weixincircle", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("微信朋友圈分享结果",plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )
    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/ShareGroup/TiktokBtn onClick 
--]]
function UserSharePanel:tiktokBtn_ScaleButton_onClick(tiktokBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "bytedance", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("抖音分享结果",plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )
    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/CloseBtn onClick 
--]]
function UserSharePanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    UIMgr:closeSpecificUI(self)
end

--[[
/ShareGroup/WeChatFriendBtn onClick 
--]]
function UserSharePanel:weChatFriendBtn_ScaleButton_onClick(weChatFriendBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "weixincircle", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("微信朋友圈分享结果",plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )

    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/ShareGroup/qqBtn onClick 
--]]
function UserSharePanel:qqBtn_ScaleButton_onClick(qqBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "qq", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("qq分享结果",plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )

    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/ShareGroup/TiktokFriendBtn onClick 
--]]
function UserSharePanel:tiktokFriendBtn_ScaleButton_onClick(tiktokFriendBtn)
    UIMgr:hideClickEffect()
    local rt = self.shareArea.rectTransform
    UMengShareActionManager.Instance:DirectShareWithCapture(
        "bytedancefriends", "避风港分享", "避风港", "",
        rt,                        -- 传 nil 则截全屏
        function(plt, code, msg)
            LuaLogger.ds("抖音好友分享结果",plt, code, msg)
            if code == 200 then
                --self:GameShareReq()
            end
        end
    )
    DLuaTimer:DoAfter(2,function()
        self:GameShareReq()
    end)
end

--[[
/downBtn onClick 
--]]
function UserSharePanel:downBtn_ScaleButton_onClick(downBtn)
    UIMgr:hideClickEffect()
    UMengShareActionManager.Instance:SaveImageToNativeGallery(
        self.shareArea.rectTransform,
        function(success, path)
            if success then
                UICommonUtils.PopToast("保存相册成功")
                LuaLogger.ds("[UserSharePanel] 保存相册成功，路径:", path)
                -- TODO: 可在此弹出提示 "保存成功"
            else
                UICommonUtils.PopToast("保存失败，请检查相册权限")  
                LuaLogger.ds("[UserSharePanel] 保存相册失败")
                -- TODO: 可在此弹出提示 "保存失败，请检查相册权限"
            end
        end
    )
end

function UserSharePanel:GameShareReq()

    --LuaLogger.ds("tablex.dump(Me.shareMap)=======",tablex.dump(Me.shareMap))
    local isAlready = false
    if Me.shareMap and Me.shareMap[GE.ShareType.common] and  Me.shareMap[GE.ShareType.common].isAlready ~= nil then
        isAlready = Me.shareMap[GE.ShareType.common].isAlready
    end
    local count = 0
    if Me.shareMap and Me.shareMap[GE.ShareType.common] and Me.shareMap[GE.ShareType.common].count ~= nil then
        count = Me.shareMap[GE.ShareType.common].count
    end

    --LuaLogger.ds("tacount=======",count,isAlready)
    if count <= 0 and isAlready == false  then
        Me:GameShareReq({shareType=GE.ShareType.common}, function(data)
            if data.rewardList then
                Me:ReceiveReward(data.rewardList)
            end
        end)
    else
        LuaLogger.ds("分享每日只能领奖一次，今日已领奖")
    end
end

return UserSharePanel
