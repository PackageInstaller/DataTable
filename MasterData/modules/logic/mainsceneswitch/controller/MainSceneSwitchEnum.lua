-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchEnum.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchEnum", package.seeall)

local MainSceneSwitchEnum = _M

MainSceneSwitchEnum.ItemTypeSelected = 1
MainSceneSwitchEnum.ItemTypeUnSelected = 2
MainSceneSwitchEnum.ItemHeight = 190
MainSceneSwitchEnum.ItemUnSelectedScale = 0.78
MainSceneSwitchEnum.ItemUnSelectedHeight = MainSceneSwitchEnum.ItemHeight * MainSceneSwitchEnum.ItemUnSelectedScale
MainSceneSwitchEnum.PageWidth = 2592
MainSceneSwitchEnum.PageSwitchTime = 2
MainSceneSwitchEnum.SceneStutas = {
	Unlock = 1,
	Lock = 2,
	LockCanGet = 3
}
MainSceneSwitchEnum.ReddotStatus = {
	Close = 1,
	Open = 2
}
MainSceneSwitchEnum.DefaultScene = 1
MainSceneSwitchEnum.SpSceneMap = {
	[4] = true,
	[6] = true
}
MainSceneSwitchEnum.SceneGCTime = {
	Default = 3,
	[6] = 5
}
MainSceneSwitchEnum.CustomScene = {
	CommandStation = 33001
}
MainSceneSwitchEnum.getCustomSceneInfo = {
	[MainSceneSwitchEnum.CustomScene.CommandStation] = {
		"scenes/v3a0_m_s18_zhb/prefab/v3a0_m_s18_zhb_p.prefab",
		"v3a0_m_s18_zhb_p",
		"v3a0_m_s18_zhb_p"
	}
}

return MainSceneSwitchEnum
