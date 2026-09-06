-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageskinintro/config/LinkageSkinIntroConfig.lua

module("logic.extensions.linkageskinintro.config.LinkageSkinIntroConfig", package.seeall)

local LinkageSkinIntroConfig = class("LinkageSkinIntroConfig", BaseConfig)

function LinkageSkinIntroConfig:onInit()
	LinkageSkinIntroConfig.super.onInit(self)
end

function LinkageSkinIntroConfig:getNames()
	return {
		"linkage_skin_intro_tab",
		"linkage_skin_intro_block"
	}
end

function LinkageSkinIntroConfig:handleConfig(name, content)
	if name == "linkage_skin_intro_tab" then
		self._linkage_skin_intro_tab = content
	elseif name == "linkage_skin_intro_block" then
		self._linkage_skin_intro_block = content
	end
end

function LinkageSkinIntroConfig:getTabsCfg()
	return self._linkage_skin_intro_tab
end

function LinkageSkinIntroConfig:getTabCfg(tabId)
	return self._linkage_skin_intro_tab[tabId]
end

function LinkageSkinIntroConfig:getBlocksByTab(tabId)
	return self._linkage_skin_intro_block[tabId]
end

function LinkageSkinIntroConfig:getBlockCfg(tabId, blockId)
	return self._linkage_skin_intro_block[tabId][blockId]
end

LinkageSkinIntroConfig.instance = LinkageSkinIntroConfig.New()

return LinkageSkinIntroConfig
