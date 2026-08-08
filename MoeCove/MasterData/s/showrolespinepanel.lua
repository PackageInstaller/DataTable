---@class ShowRoleSpinePanel : ShowRoleSpinePanel_Generate
---##################### 【ShowRoleSpinePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ShowRoleSpinePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ShowRoleSpinePanel = require "ShowRoleSpinePanel_Generate"

function ShowRoleSpinePanel:InitLogic(data)
    self.spineList = {}

    self.stopTalkActionTimerList = {}

    self.showType = 1   --1Action表组合 2单个动画

    self.spineType = 1  --1角色 2场景

    self.colorStrList = {"FFFE8F", "B3FF8F", "8FD1FF", "FF8F8F", "FF8FE3"}
end

function ShowRoleSpinePanel:InitPanel()
    
end

function ShowRoleSpinePanel:setRoleSpine()
    local resName, resPath
    if self.spineType == 1 then
        resName = "Role_" .. self.nowRoleResName
        resPath = Config.PrefabPath.RoleSpine
    elseif self.spineType == 2 then
        resName = "Scene_" .. self.nowRoleResName
        resPath = Config.PrefabPath.SceneSpine
    end

    local prefabPath = string.format(resPath, resName, resName)
    if self.spineList[self.nowRoleResName] then
        self.spineList[self.nowRoleResName]:SetActive(true)
        self:showTableGroup()
        self.trackGroup:SetActive(false)
    else
        ResMgr:LoadPrefabAsync(prefabPath, function (obj)
            local spineObject = Instantiate(obj).gameObject
            spineObject:SetParent(self.roleSpineRoot.transform)
            self.spineList[self.nowRoleResName] = spineObject

            --根据配置处理角色偏移和缩放
            local spineId = tonumber(self.nowRoleResName) or 0
            local storyResConfig = Config.GetStoryResourceInfo(spineId)
            local offset = storyResConfig and storyResConfig.offset or {0, 900}
            local scale = storyResConfig and storyResConfig.scale or 1
            local objRect = spineObject:GetComponent("RectTransform")
            objRect.anchoredPosition = Vector2.New(offset[1], offset[2])
            objRect.localScale = Vector3.New(scale, scale, 1)

            --剧情关闭spine物理效果
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero

            self:showTableGroup()
            self.trackGroup:SetActive(false)
        end)
    end
end

function ShowRoleSpinePanel:showSingleAnimation()
    local roleName = self.nowRoleResName
    --self.testSpineAnimation = self.spineList[roleName]:GetComponent("SetSpineAnimation")
    local objSpine = self.spineList[roleName]:GetComponent("SkeletonGraphic")
    local objSpineAnim = self.spineList[roleName]:GetComponent("SkeletonAnimation")
    self:clearTrackData(objSpine, objSpineAnim)
    self:removePanelTimer()
    local spineAnimList = objSpine.Skeleton.Data.Animations:ToArray()

    self.animBtnDataList = {}
    self:FillTemplateContent(self.groupBox, self.content, spineAnimList.Length, function(index, groupBox)
        local animName = spineAnimList[index - 1].Name
        groupBox.actionGroupText.text.text = animName
        groupBox.scaleButton.onClick:RemoveAllListeners()
        groupBox.scaleButton.onClick:AddListener(function()
            objSpineAnim.AnimationState:SetAnimation(self.nowSelectTrack, animName, true)
            self.trackBtnList[self.nowSelectTrack].image.color = Color.NewFromStr(self.colorStrList[self.nowSelectTrack])
            for _, data in pairs(self.animBtnDataList) do
                if data.trackIndex == self.nowSelectTrack then
                    data.obj.image.color = Color.NewFromStr("FFFFFF")
                end
                if animName == data.animName then
                    data.trackIndex = self.nowSelectTrack
                    data.obj.image.color = Color.NewFromStr(self.colorStrList[self.nowSelectTrack])
                end
            end
        end)
        self.animBtnDataList[index] = {
            obj = groupBox,
            trackIndex = 0,
            animName = animName,
        }
    end)
    --029111
    self.trackBtnList = {}
    --self.trackAnimList = {}
    self.nowSelectTrack = 1
    self:FillTemplateContent(self.trackBtn, self.trackGroup, 6, function(index, trackBtn)
        trackBtn.isSelect:SetActive(index == self.nowSelectTrack)
        if index <= 5 then
            trackBtn.trackNum.text.text = index
            trackBtn.scaleButton.onClick:RemoveAllListeners()
            trackBtn.scaleButton.onClick:AddListener(function()
                self.nowSelectTrack = index
                for index, trackBtn in pairs(self.trackBtnList) do
                    trackBtn.isSelect:SetActive(index == self.nowSelectTrack)
                end
            end)
            self.trackBtnList[index] = trackBtn
        else
            trackBtn.trackNum.text.text = "X"
            trackBtn.image.color = Color.NewFromStr("DA2525")
            trackBtn.scaleButton.onClick:RemoveAllListeners()
            trackBtn.scaleButton.onClick:AddListener(function()
                self:clearTrackData(objSpine, objSpineAnim)
            end)
        end
    end)
end

function ShowRoleSpinePanel:clearTrackData(objSpine, objSpineAnim)
    self.nowSelectTrack = 1
    for track, trackBtn in pairs(self.trackBtnList or {}) do
        trackBtn.image.color = Color.NewFromStr("FFFFFF")
        trackBtn.isSelect:SetActive(self.nowSelectTrack == track)
    end
    for index, data in pairs(self.animBtnDataList or {}) do
        data.obj.image.color = Color.NewFromStr("FFFFFF")
        data.trackIndex = 0
    end
    objSpineAnim.AnimationState:ClearTracks()
    objSpine:Initialize(true)
end

function ShowRoleSpinePanel:showTableGroup()
    local roleCid = tonumber(self.nowRoleResName) or 0
    local value = Config.GetAllConfig("ActionTable")
    local nameGroup = {}
    local tableGroup = {}
    for _, v in ipairs(value) do
        if v.character == roleCid and not nameGroup[v.group] then
            nameGroup[v.group] = 1
            table.insert(tableGroup, v.group)
        end
    end

    self:FillTemplateContent(self.groupBox, self.content, #tableGroup, function(index, groupBox)
        groupBox.actionGroupText.text.text = tableGroup[index]
        groupBox.image.color = Color.NewFromStr("FFFFFF")
        groupBox.scaleButton.onClick:RemoveAllListeners()
        groupBox.scaleButton.onClick:AddListener(function()
            self:removePanelTimer()
            self:SetCharacterSpine(self.spineList[self.nowRoleResName], Config.GetActionInfoByGroup(tableGroup[index]))
        end)
    end)
end

function ShowRoleSpinePanel:SetCharacterSpine(nowObj, actionList)
    --表情动作双轨道
    if not UICommonUtils.Checkobj(nowObj) then
        return
    end
    local spineAnimation = nowObj:GetComponent("SetSpineAnimation")
    local objSpine = nowObj:GetComponent("SkeletonGraphic")
    local objSpineAnim = nowObj:GetComponent("SkeletonAnimation")

    --首先分出表情与动作
    local poseList = {}
    local emoteList = {}
    local text3List = {}
    local text4List = {}
    local text5List = {}
    for _, actionConfig in pairs(actionList) do
        if actionConfig.basicType == GE.RoleSpineActionType.Emote then
            table.insert(emoteList, actionConfig)
        elseif actionConfig.basicType == GE.RoleSpineActionType.Action then
            --先将需要拼接的动作拆分放入列表
            local nameBreakList = {}
            local lastEndName = ""
            local newBeginName = ""
            local skipAutoFuse = false
            string.gsub(actionConfig.resource,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                newBeginName = nameBreakList[1].."_begin"
            end

            --如果主动配置了首尾动画则不拼接
            if nameBreakList[2] == "begin" or nameBreakList[2] == "end" then
                skipAutoFuse = true
            end

            local lastNameBreak = {}
            local currentActionTrack = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
            local currentAnimName = (currentActionTrack ~= nil and currentActionTrack.Animation ~= nil) and currentActionTrack.Animation.Name or ""
            string.gsub(currentAnimName,'[^'.."_"..']+',function ( w )
                table.insert(lastNameBreak, w)
            end)
            if #lastNameBreak > 1 then
                lastEndName = lastNameBreak[1].."_end"
            end

            local newActConfig = {
                basicType = GE.RoleSpineActionType.Action,
                actType = 2,
            }

            if lastEndName ~= "" and spineAnimation:CheckAnimationExist(lastEndName) and not skipAutoFuse then
                newActConfig.resource = lastEndName
                table.insert(poseList, clone(newActConfig))
            end

            if newBeginName ~= "" and spineAnimation:CheckAnimationExist(newBeginName) and not skipAutoFuse then
                newActConfig.resource = newBeginName
                table.insert(poseList, clone(newActConfig))
            end

            table.insert(poseList, actionConfig)
        elseif actionConfig.basicType == 3 then
            table.insert(text3List, actionConfig)
        elseif actionConfig.basicType == 4 then
            table.insert(text4List, actionConfig)
        elseif actionConfig.basicType == 5 then
            table.insert(text5List, actionConfig)
        end
    end

    --动作轨道
    for k, poseConfig in pairs(poseList) do
        local setTrack = poseConfig.basicType
        local poseName = poseConfig.resource
        local isLoop = poseConfig.actType == 1

        if k == 1 then
            objSpineAnim.AnimationState:SetAnimation(setTrack, poseName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(self[nowObj.name .. "PoseNow"]).Duration
            objSpineAnim.AnimationState:AddAnimation(setTrack, poseName, isLoop, defaultTime)
        end

        self[nowObj.name .. "PoseNow"] = poseName
    end
    --LuaLogger.ds(">>>>>!!!!<<<<", tablex.dump(poseList))

    --表情轨道
    for k, emoteConfig in pairs(emoteList) do
        local setTrack = emoteConfig.basicType
        local emoteName = emoteConfig.resource
        local isLoop = emoteConfig.actType == 1

        if k == 1 then
            objSpineAnim.AnimationState:SetAnimation(setTrack, emoteName, isLoop)
        else
            local defaultTime = objSpine.Skeleton.Data:FindAnimation(self[nowObj.name .. "EmoteNow"]).Duration
            objSpineAnim.AnimationState:AddAnimation(setTrack, emoteName, true, defaultTime)
        end

        self[nowObj.name .. "EmoteNow"] = emoteName
    end
    --TODO嘴型匹配文字长度
    if next(emoteList) then
        self.stopTalkActionTimerList[nowObj.name] = DLuaTimer:DoAfter(10, function()
            local emoteTrack = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
            local nowEmoteName = (emoteTrack ~= nil and emoteTrack.Animation ~= nil) and emoteTrack.Animation.Name or ""
            local nameBreakList = {}
            local newEomteName = ""
            string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
                table.insert(nameBreakList, w)
            end)
            if #nameBreakList > 1 then
                newEomteName = nameBreakList[1]
            end
            if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
                objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
            else
                objSpineAnim.AnimationState:ClearTrack(GE.RoleSpineActionType.Emote)
            end
        end)
    end

    --测试轨道
    if next(text3List) then
        for k, v in pairs(text3List) do
            objSpineAnim.AnimationState:SetAnimation(3, v.resource, true)
        end
    end
    if next(text4List) then
        for k, v in pairs(text4List) do
            objSpineAnim.AnimationState:SetAnimation(4, v.resource, true)
        end
    end
    if next(text5List) then
        for k, v in pairs(text5List) do
            self.testTrack = objSpineAnim.AnimationState:SetAnimation(5, v.resource, false)
            self.testTrack.TimeScale = 0
        end
    end
end

function ShowRoleSpinePanel:Update()

end

--function ShowRoleSpinePanel:StartCreating(time)
--
--end

--function ShowRoleSpinePanel:StartEnter(time)
--
--end

--function ShowRoleSpinePanel:StartRemoving(time)
--
--end

--function ShowRoleSpinePanel:StartExit(time)
--
--end

function ShowRoleSpinePanel:OnOpen(data, initiative)
    self:InitPanel()
end

--function ShowRoleSpinePanel:OnClose(initiative)
--
--end

--function ShowRoleSpinePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ShowRoleSpinePanel:OnRefresh(data)
--
--end

--移除界面Timer
function ShowRoleSpinePanel:removePanelTimer()
    if next(self.stopTalkActionTimerList) then
        for _, timer in pairs(self.stopTalkActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
    end
end

--[[
/ExitBtn onClick 
--]]
function ShowRoleSpinePanel:exitBtn_Button_onClick(exitBtn)
    self:removePanelTimer()
    UIMgr:closeUI(self)
end

--[[
/RoleIDInputField onEndEdit 
--]]
function ShowRoleSpinePanel:roleIDInputField_InputField_onEndEdit(roleIDInputField,content)
    if self.nowRoleResName ~= roleIDInputField.inputField.text then
        --直接根据名称加载
        if self.spineList[self.nowRoleResName] then
            self.spineList[self.nowRoleResName]:SetActive(false)
        end
        self.nowRoleResName = roleIDInputField.inputField.text
        self:setRoleSpine()
    end
end

--[[
/ChangeTypeBtn onClick 
--]]
function ShowRoleSpinePanel:changeTypeBtn_Button_onClick(changeTypeBtn)
    self.showType = self.showType == 1 and 2 or 1
    if self.showType == 1 then
        self:showTableGroup()
    elseif self.showType == 2 then
        self:showSingleAnimation()
    end
    self.trackGroup:SetActive(self.showType == 2)
end

--[[
/Scrollbar onValueChanged 
--]]
function ShowRoleSpinePanel:scrollbar_Scrollbar_onValueChanged(scrollbar,value)
    --local maxTime = self.testTrack.AnimationEnd

    --self.testTrack.TrackTime = maxTime * value

    --self.testSpineAnimation:SetSliderTime("control", value)
end

--[[
/RoleTypeBtn onClick 
--]]
function ShowRoleSpinePanel:roleTypeBtn_Button_onClick(roleTypeBtn)
    self.spineType = 1
    self.roleIDInputField.inputField.text = ""
    self.roleIDInputField.inputField.placeholder:GetComponent("Text").text = "角色资源名"
end

--[[
/SceneTypeBtn onClick 
--]]
function ShowRoleSpinePanel:sceneTypeBtn_Button_onClick(sceneTypeBtn)
    self.spineType = 2
    self.roleIDInputField.inputField.text = ""
    self.roleIDInputField.inputField.placeholder:GetComponent("Text").text = "场景资源名"
end

return ShowRoleSpinePanel
