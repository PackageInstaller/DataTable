---@class NoticePanel : NoticePanel_Generate
---##################### 【NoticePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【NoticePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local NoticePanel = require "NoticePanel_Generate"
local Screen = UnityEngine.Screen
local ScreenOrientation = UnityEngine.ScreenOrientation

function NoticePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.NoticeRefresh, self:refreshNotice()},
	}
end

--function NoticePanel:StartCreating(time)
--
--end

--function NoticePanel:StartEnter(time)
--
--end

--function NoticePanel:StartRemoving(time)
--
--end

--function NoticePanel:StartExit(time)
--
--end

function NoticePanel:OnOpen(data, initiative)
    if initiative then
        --加载完show
        local startFunc = function()
            LuaLogger.ds("NoticePanel OnPageFinished")
            self.webArea.uniWebView:UpdateFrame()
            self.webArea.uniWebView:Show()
        end
        self.webArea.uniWebView.OnPageFinished = self.webArea.uniWebView.OnPageFinished + startFunc
    end

    --初始化页签
    local targetIndex = (data and data.index) and data.index or 1
    self:changePage(targetIndex)
    self:refreshPage()
end

function NoticePanel:refreshNotice()
    self:refreshPage()
end

--切换页签
--@param {int}  index   切换目标页签 GE.NoticePage
function NoticePanel:changePage(index)
    self.currentPage = index
    local toggleList = {
        [GE.NoticePage.Event] = self.activityBtn.isSelect,
        [GE.NoticePage.System] = self.systemBtn.isSelect,
    }
    --UI显隐
    for page, obj in pairs(toggleList) do
        obj:SetActive(index == page)
    end
    self.systemTitleTxt.text.color = index == GE.NoticePage.System and Color.NewFromStr("FFFFFF") or Color.NewFromStr("333333")
    self.systemTitleIcon.image.color = index == GE.NoticePage.System and Color.NewFromStr("FFFFFF") or Color.NewFromStr("333333")
    self.activityTitleTxt.text.color = index == GE.NoticePage.Event and Color.NewFromStr("FFFFFF") or Color.NewFromStr("333333")
    self.activityTitleIcon.image.color = index == GE.NoticePage.Event and Color.NewFromStr("FFFFFF") or Color.NewFromStr("333333")
end

--刷新页面
function NoticePanel:refreshPage()
    local noticeList = ClientData:GetAllNoticeData() or {}
    LuaLogger.ds(tablex.dump(noticeList))
    local result = {}
    local temp = {
        [GE.NoticePage.Event] = 1,
        [GE.NoticePage.System] = 2,
    }
    local typeToType = {
        [temp[GE.NoticePage.Event]] = {1},
        [temp[GE.NoticePage.System]] = {2, 3},
    }
    for k, v in pairs(noticeList) do
        --时间边界判断
        local canShow = true
        if v.start_time and v.start_time ~= "" then
            local startTime = DLuaUtil.ParseConfigTimeClient(v.start_time)
            if startTime > os.time() then
                canShow = false
            end
        end
        if v.end_time and v.end_time ~= "" then
            local endTime = DLuaUtil.ParseConfigTimeClient(v.end_time)
            if endTime < os.time() then
                canShow = false
            end
        end
        if canShow and Me.uid then
            v.showRed = not RedPointMgr:GetRedDotState("Notice"..v.id)
            self:setToggleRedPoint(v)
        end
        if canShow and typeToType[self.currentPage] and tablex.contains(typeToType[self.currentPage], v.type) then
            table.insert(result, v)
        end
    end
    --排序
    local order ={
        [1] = "is_top",
        [2] = "sort",
        [3] = "start_time",
    }
    --排序规则 1为降序 -1为升序
    local orderRule = {
        ["is_top"] = 1,
        ["start_time"] = -1,
        ["sort"] = 1,
    }
    local sortFunc = function(a, b)
        for _, key in ipairs(order) do
            if a[key] ~= b[key] then
                return orderRule[key] * (a[key] > b[key] and 1 or -1) > 0
            end
        end
        return false
    end
    -- LuaLogger.ds("排序前", tablex.dump(result))
    table.sort(result, function(a, b)
        return sortFunc(a, b)
    end)
    -- LuaLogger.ds("排序后", tablex.dump(result))
    --公告复选格子
    self:FillTemplateContent(self.noticeBox, self.noticeBoxList, tablex.size(result), function (index,noticeBox)
        local noticeData = result[index]
        noticeBox.noticeTitleTxt.text.text = DLuaUtil.SetOverLengthStrToEllipsis(noticeData.title, 50)
        noticeBox.noticeTitleTxt.text.color = Color.NewFromStr("17181E")
        noticeBox.scaleButton.onClick:RemoveAllListeners()
        noticeBox.scaleButton.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self:selectBox(noticeBox, noticeData)
        end)
        if Me.uid then
            noticeBox.red:SetActive(noticeData.showRed)
        end
        if index == 1 then
            self:selectBox(noticeBox, noticeData)
        end
    end)
end

--选中格子
function NoticePanel:selectBox(noticeBox, noticeData)
    if self.nowSelectbox and UICommonUtils.Checkobj(self.nowSelectbox) then
        self.nowSelectbox.isSelect:SetActive(false)
        self.nowSelectbox.noticeTitleTxt.text.color = Color.NewFromStr("17181E")
    end
    self.nowSelectbox = noticeBox
    self.nowSelectbox.isSelect:SetActive(true)
    self.nowSelectbox.noticeTitleTxt.text.color = Color.NewFromStr("ECF8FF")

    if Me.uid then
        RedPointMgr:SetRedDotState("Notice"..noticeData.id, true)
        RedPointMgr:Refresh("NoticeRedJudge")
        noticeBox.red:SetActive(false)
        if noticeData.type == 1 then
            self.activityBtn.red:SetActive(false)
        elseif noticeData.type == 2 then
            self.systemBtn.red:SetActive(false)
        end
    end

	LuaLogger.ds("公告Url", noticeData.web_url)
    if GV.IsEditor then
        Application.OpenURL(noticeData.web_url)
    end
    self.webArea.uniWebView:SetCalloutEnabled(false)
    self.webArea.uniWebView:Load(noticeData.web_url)
    self.webArea.uniWebView:Show()
end

--设置页签红点状态
function NoticePanel:setToggleRedPoint(noticeData)
    if noticeData.type == 1 and not self.activityBtn.red.activeSelf then
        self.activityBtn.red:SetActive(noticeData.showRed)
    elseif noticeData.type == 2 and not self.systemBtn.red.activeSelf then
        self.systemBtn.red:SetActive(noticeData.showRed)
    end
end

--界面关闭
function NoticePanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.webArea.uniWebView:Hide()
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function NoticePanel:OnClose(initiative)
--
--end

--function NoticePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function NoticePanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function NoticePanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/NoticeBg/CloseBtn onClick 
--]]
function NoticePanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/BoxBg/ToggleBtnGroup/ActivityBtn onClick 
--]]
function NoticePanel:activityBtn_Button_onClick(activityBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:changePage(1)
    self:refreshPage()
end

--[[
/BoxBg/ToggleBtnGroup/SystemBtn onClick 
--]]
function NoticePanel:systemBtn_Button_onClick(systemBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:changePage(2)
    self:refreshPage()
end

return NoticePanel
