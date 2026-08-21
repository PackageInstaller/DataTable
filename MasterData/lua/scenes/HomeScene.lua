--[[
-- added by wsh @ 2017-11-19
-- 主页场景
--]]

local HomeScene = BaseClass("HomeScene", BaseScene)
local base = BaseScene

-- 创建：准备预加载资源
local function OnEnter(self)
	base.OnEnter(self)
	self:AddPreloadResource(UIConfig[UIWindowNames.UIHome].PrefabPath, typeof(CS.UnityEngine.GameObject), 1); -- 必须预加载 且常驻
	self:AddPreloadResource(UIConfig[UIWindowNames.UIComTop].PrefabPath, typeof(CS.UnityEngine.GameObject), 1); -- 必须预加载 且常驻
	self:AddPreloadResource(UIConfig[UIWindowNames.UITransition].PrefabPath, typeof(CS.UnityEngine.GameObject), 1); -- 必须预加载 且常驻
	self:AddPreloadResource(UIConfig[UIWindowNames.UICardIntens].PrefabPath, typeof(CS.UnityEngine.GameObject), 1); -- 界面图片资源大
	self:AddPreloadResource(UIConfig[UIWindowNames.UISummon].PrefabPath, typeof(CS.UnityEngine.GameObject), 1); -- 界面图片资源大
	-- 不要随便添加预加载   否则加载时间长
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIPlayerInfo].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIPlayerInceptionInfo].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UINoviceGuide].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UICardList].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIFormatNew].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIMainIntens].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIRoom].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIBattleMode].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UITask].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIProp].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UILaunchAtk].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UILaunchAtkBg].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIDialog].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIHandBookMain].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UISummonStage1].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UICardEvolveStage3].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	--self:AddPreloadResource(UIConfig[UIWindowNames.UIGeneralShop].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	-- 预加载记录栈
	local stack = UIManager:GetInstance():GetWindowStack()
	table.walk(stack, function (k, v)
		self:AddPreloadResource(UIConfig[v].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	end)
end

--新手引导
local function GuideChose(TemplateIds)
	local guideDataList={}
	local guide=Game.Scene:GetComponent("GuideComponent")
	local view = nil
	if UIManager:GetInstance():GetLastBgWindowName() == UIWindowNames.UIHome then
		local windowH = UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
		if windowH == nil then
			return
		end
		view = windowH.View
	end
	for k, v in pairs(TemplateIds) do
		local guideData = table.first(guide.GuideList,function (h) return h.Id==v  end)
		if guideData~=nil then
			table.insert(guideDataList,guideData)
		end
	end
	if table.count(guideDataList)==0 then
		if view ~= nil then
			view.eventImg:SetActive(true)
		end
		guide:CheckStart(1,0)
	else
		table.sort(guideDataList,function(a, b)  return a.Id>b.Id end)
		local guideStep=guideDataList[1]
		local guideComplete = tonumber(string.sub(tostring(guideStep.Id),1,1))-1
		if guideComplete < 3 then--3_0之后是触发式引导。不需要直接进入引导状态
			if view ~= nil then
				view.eventImg:SetActive(true)
			end
			if guideStep.Step < guide.TotalStep[guideComplete+1] then
				local str = math.floor(guideStep.Id/1000) - 1 .."_"..guideStep.Step
				local step = table.first(Z_NoviceGuide,function(v) return v.Step==str  end)
				guide:OnClickOpenView(step.ContinueCode)
			elseif guideStep.Step >= guide.TotalStep[guideComplete+1] then
				if guideComplete < 3 then
					guide:CheckStart(guideComplete+1,0)
				end
			end
		end
	end
end

-- 准备工作
local function OnComplete(self)
	base.OnComplete(self)
	Time.timeScale = 1
	UIManager:GetInstance():OpenWindow(UIWindowNames.UITransition)

	--新手引导
	local guide=Game.Scene:GetComponent("GuideComponent")
	-- local Story=Game.Scene.Player:GetComponent("StoryComponent")
	local GuideStep = table.first(guide.GuideList,function (v) return v.Id==FirstGuideId  end)
	local guideStep1 = table.first(guide.GuideList,function (v) return v.Id==BattleGuideId  end)
	-- local guideStep2 = table.first(guide.GuideList,function (v) return v.Id==11001  end) --信条
	local guideStep3 = table.first(guide.GuideList,function (v) return v.Id==3001  end) -- 出击

	if CS.Game.Instance.settings.guideEnabled then
		if GuideStep ~= nil then
			if GuideStep["Step"] < 7 then
				UIManager:GetInstance():OpenWindow(UIWindowNames.UIPlayerInceptionInfo)
			end
		else
			UIManager:GetInstance():OpenWindow(UIWindowNames.UIPlayerInceptionInfo)
		end	
	end
	
	local againstComponent = Game.Scene:GetComponent("AgainstComponent")
	if not Game.Scene:GetComponent("AgainstComponent").StorySkip and
			Game.Scene:GetComponent("AgainstComponent").BattleWin 
			 then

		if againstComponent.LevelType == LevelType.LevelTypeStory then
			local levelId = againstComponent.BattleData.Story.CurLevelId
			local zStorySection = Z_StorySection[levelId]
			Game.Scene:GetComponent("DialogComponent"):OpenDialog(zStorySection.ChapterId, zStorySection.StoryId, StoryMode.BattleAfter, function ()
				--coroutine.start(function ()
					--coroutine.waitforframes(1)
					--Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
				--end, false)
			end)

			coroutine.waitforframes(1)
			UIManager:GetInstance():OpenWindowStack(UIWindowNames.UIHome) -- 打开记录栈的窗口，没有的话就打开UIHome
			return
		end

		if againstComponent.LevelType == LevelType.LevelTypeGameEvent then
			local levelId = againstComponent.BattleData.GameEvent.CurLevelId
			local zStorySection = Z_GameEventsLevel[levelId]
			Game.Scene:GetComponent("DialogComponent"):OpenDialog(zStorySection.ChapterId, zStorySection.StoryId, StoryMode.BattleAfter, function ()
				--coroutine.start(function ()
					--coroutine.waitforframes(1)
					--Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
				--end, false)
			end)

			coroutine.waitforframes(1)
			UIManager:GetInstance():OpenWindowStack(UIWindowNames.UIHome) -- 打开记录栈的窗口，没有的话就打开UIHome
			return
		end
	end

	coroutine.waitforframes(1)
	if CS.Game.Instance.settings.guideEnabled then
		if GuideStep ~= nil then
			if GuideStep["Step"] < 7 then
				--UIManager:GetInstance():OpenWindow(UIWindowNames.UIPlayerInceptionInfo)
			elseif guideStep1 == nil or guideStep1["Step"] < 3 then
				guide:CheckStart(0, 0)
			elseif guideStep3 ~= nil and guideStep3.Step >= 2 and guide.GuideRun == false then
				if UIManager:GetInstance():GetLastBgWindowName() == UIWindowNames.UIHome then
					local windowH = UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
					local view = windowH.View
					view:ToolTip()
				end
			else
				-- gh: 暂时屏蔽 抽卡引导
				local TemplateIds = { 2001, 3001 }
				GuideChose(TemplateIds)
			end
		else
			--UIManager:GetInstance():OpenWindow(UIWindowNames.UIPlayerInceptionInfo)
		end
	end
	coroutine.waitforframes(1)

	UIManager:GetInstance():OpenWindowStack(UIWindowNames.UIHome) -- 打开记录栈的窗口，没有的话就打开UIHome


	--新手引导
	--local cd = ClientData:GetInstance()
	--if cd~=nil and cd.guide  then
		
		--if table.length(guide.GuideList)>0 then
		--if Game.Scene:GetComponent("AgainstComponent").BattleWin and
		--		againstComponent.LevelType == LevelType.LevelTypeTower  then--解锁第一个信条技能后跳转到home场景
		--	if Story.CompletedLordRoad == 101 and (guideStep2 == nil or guideStep2.Step < 9) then
		--		guide:CheckStart(10,0)
		--	end
		--end

	
	--if guideStep1 ~= nil and guideStep1["Step"] >= 20 then
	--	Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Home")
	--else
	--	Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "HandBook")
	--end
end

-- 离开场景
local function OnLeave(self)
	UIManager:GetInstance():CloseWindow(UIWindowNames.UITransition)
	base.OnLeave(self)
end

HomeScene.OnEnter = OnEnter
HomeScene.OnComplete = OnComplete
HomeScene.OnLeave = OnLeave

return HomeScene;