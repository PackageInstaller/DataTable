--简单的剧情播放界面(用于播放类型为2的剧情演出)
local isJump = false;
local storyData = nil;
local isPlaying = false;
local playSpeed = 0.05;--文字播放速度，值越小越快
function OnDestroy()
	EventMgr.Dispatch(EventType.Replay_BGM);
	storyData = nil;
	currentPlotData = nil;
	RecordMgr:Save(RecordMode.View, CSAPI.GetRealTime(), "ui_id=" .. RecordViews.Plot);	

	TryCallBack();
end

function OnOpen()
	if data == nil then
		LogError("章节ID不能为空！");
		return;
	end
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		if tostring(data.storyID)=="10051" then
			BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_FIGHT_START)
		end
	end
	storyData = StoryData.New();
	storyData:InitCfg(data.storyID);
	currentPlotData = storyData:GetBeginPlotData();
	PlotTween.FadeIn(rootNode, nil, function()
		isPlaying = true;
		PlayPlot()
	end);
	
	LanguageMgr:SetText(txt_auto, 19000)
end

function OnDisable()
	TryCallBack();
	
	data = nil;
end

function TryCallBack()
    if(data and data.playCallBack) then
		local callBack = data.playCallBack;
		callBack(data.caller);
        data.playCallBack = nil;
        data.caller = nil;
		--LogError("播放结束回调");	
	end
end

--点击任意地方
function OnClickAnyway()
	if not IsPlayOver() then
		if isPlaying == false then
			-- 播放下一条对话
			PlayNext();
		else
			CSAPI.ApplyTextTweenFull(txt_content);
			isPlaying = false;
		end
	else
		Close();
	end
end

--播放下一条
function PlayNext()
	local tempData = currentPlotData:GetNextPlotInfo();
	if tempData ~= nil then
		currentPlotData = tempData;
		PlayPlot();
	else
		Close();
	end
end

--当前整段对话是否播放完毕
function IsPlayOver()
	local playOver = false;
	if isPlaying == false and currentPlotData:IsLastContent() then
		playOver = true;
	end
	return playOver;
end

--点击跳过
function OnClickJump()
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		if data and (tostring(data.storyID)=="10051" or tostring(data.storyID)=="10052" or tostring(data.storyID)=="10054") then
			BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_FIGHT_SKIP)
		end
	end

	--渐隐子物体
	RecordMgr:SaveCount(RecordMode.Count, RecordViews.PlotJump, storyData:GetID());	
	Close();
end

--播放剧情对话
function PlayPlot()
	if currentPlotData:IsLastContent() == false then
		local textContent = currentPlotData:GetContent();
		local talkName = currentPlotData:GetTalkName()
		if talkName == nil or talkName == "" then
			CSAPI.SetGOActive(titleObj, false);
		else
			CSAPI.SetGOActive(titleObj, true);
			CSAPI.SetText(txt_title1, talkName);
			CSAPI.SetText(txt_title2, currentPlotData:GetTalkEnName());
		end
		local talker = currentPlotData:GetTalkInfo();
		--设置头像
		if currentPlotData:IsLeader() then
			ResUtil.RoleCard:Load(icon, PlayerClient:GetIconName(), true);
		elseif talker:GetIcon() ~= nil then
			ResUtil.RoleCard:Load(icon, talker:GetIcon(), true);
		else
			LogError("未找到头像信息：" .. talker:GetID());
		end
		isPlaying = true;
		CSAPI.ApplyTextTween(txt_content, textContent, playSpeed, OnPlotOver);
		--打点
		local recordId = currentPlotData.cfg.record_id
		if recordId then
			BuryingPointMgr:BuryingPoint("after_login",recordId)
		end
	else
		isPlaying = false;
		-- OnPlotOver();
	end
end

--剧情播放完成时
function OnPlotOver()
	isPlaying = false;
end

function Close()
	PlotTween.FadeOut(rootNode, nil, function()
		CSAPI.SetGOActive(rootNode, false);
		view:Close();
	end);
    TryCallBack();
end 