--[[
-- added by wsh @ 2017-11-18
-- 登陆场景
--]]

local LoginScene = BaseClass("LoginScene", BaseScene)
local base = BaseScene

-- 创建：准备预加载资源
local function OnEnter(self)
	base.OnEnter(self)
	
	self.AutoLogin = true
	self:AddPreloadResource(UIConfig[UIWindowNames.UILoading].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
	self:AddPreloadResource(UIConfig[UIWindowNames.UILoad].PrefabPath, typeof(CS.UnityEngine.GameObject), 1);
	self:AddPreloadAssetBundle("sound/ui")
	self:AddPreloadResource("UI/Effects/PointEffect.prefab", typeof(CS.UnityEngine.GameObject), 1)

	local tab = {}
	table.walk(LoadingBg, function (k, v)
		tab[k] = "UI/LoadBg_"..LangUtil.GetLangType().."/"..v
	end)
	table.walk(tab, function (k, v) self:AddPreloadResource(v, typeof(CS.UnityEngine.Sprite)) end)
end

-- 准备工作
local function OnComplete(self)
	base.OnComplete(self)
	Time.timeScale = 1
	-- 设置字体
	LangUtil.LoadFonts()
	
	-- 清除玩家数据缓存
	if Game.Scene.Player ~= nil then
		Game.Scene.Player:Dispose()
		Game.Scene:SetPlayer()
		---@type Player
		Game.Scene.Player = nil
	end
	-- 清除界面缓存
	UIManager:GetInstance():ClearWindowStack()

	-- 退出需要清理缓存（玩家缓存得清理），断线重连不需要（保存的本地数据不能清空了）
	local safeAddComponent = function (componentName)
		if Game.Scene:GetComponent(componentName) ~= nil then
			Game.Scene:RemoveComponent(componentName)
		end
		return Game.Scene:AddComponent(componentName)
	end
	safeAddComponent("CompetitionComponent")
	safeAddComponent("GuideComponent")
	safeAddComponent("HintComponent")
	safeAddComponent("AgainstComponent")
	safeAddComponent("SupCardComponent")

	-- 被挤下线
	if Game.Scene:GetComponent("SessionComponent").forceOffLine == 1 then
		UIUtil.ToolTipFourth(LangUtil.GetSysLang(1080))
	elseif Game.Scene:GetComponent("SessionComponent").forceOffLine == 2 then
		UIUtil.ToolTipFourth(LangUtil.GetSysLang(3077))
	end
	UIManager:GetInstance():OpenWindow(UIWindowNames.UISsLogin, self.AutoLogin)
end

-- 离开场景
local function OnLeave(self)
	UIManager:GetInstance():CloseWindow(UIWindowNames.UISsLogin)
	base.OnLeave(self)
end

LoginScene.OnEnter = OnEnter
LoginScene.OnComplete = OnComplete
LoginScene.OnLeave = OnLeave

return LoginScene;