-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/config/WishTreeConfig.lua

module("logic.extensions.wishtree.config.WishTreeConfig", package.seeall)

local WishTreeConfig = class("WishTreeConfig", BaseConfig)

function WishTreeConfig:onInit()
	WishTreeConfig.super.onInit(self)
end

function WishTreeConfig:getNames()
	return {
		"wish_tree_activity",
		"wish_tree_wish",
		"wishtree_reward"
	}
end

function WishTreeConfig:handleConfig(name, content)
	if name == "wish_tree_activity" then
		self._wish_tree_activity = content
	elseif name == "wish_tree_wish" then
		self._wish_tree_wish = content
	elseif name == "wishtree_reward" then
		self._wishtree_reward = content
	end
end

function WishTreeConfig:getWishTreeCfgsByActId(actId)
	return self._wish_tree_activity[actId]
end

function WishTreeConfig:getWishTreeWishCfgs(planId)
	return self._wish_tree_wish[planId]
end

function WishTreeConfig:getWishTreeWishCfgsById(planId, id)
	local cfgs = self._wish_tree_wish[planId]

	if cfgs then
		return cfgs[id]
	end

	return nil
end

function WishTreeConfig:getWishTreeRewardCfgs(planId)
	return self._wishtree_reward[planId]
end

function WishTreeConfig:getWishTreeRewardCfgsById(planId, id)
	local cfgs = self._wishtree_reward[planId]

	if cfgs then
		return cfgs[id]
	end

	return nil
end

WishTreeConfig.instance = WishTreeConfig.New()

return WishTreeConfig
