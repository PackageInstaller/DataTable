-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/AreanaNewLoadingModel.lua

AreanaNewLoadingModel = class("AreanaNewLoadingModel", objectlua.Object, _M)

local preloadResConfig = {
	HeroShowListView = {
		image = {
			"asset/ui/common_scale9New.png",
			"asset/ui/heroShow_resRaw.png",
			"asset/ui/heroShow_newres.png",
			"asset/ui/heroShow_res.png",
			"asset/ui/common_newres.png",
			"asset/ui/common_heros.png",
			"asset/ui/common_scale9.png",
			"asset/ui/common_buttons.png",
			"asset/ui/common_res.png",
			"asset/anim/pinjiwenziimage.png",
			"asset/anim/touxiangkuangimage.png",
			"asset/anim/commonimage.png"
		}
	},
	StageTeamView = {
		image = {
			"asset/ui/common_heroIcon.png"
		}
	},
	BuildingOverviewView = {
		image = {
			"asset/ui/building_newres.png",
			"asset/ui/common_res.png",
			"asset/anim/huodetishiimage.png"
		}
	},
	ClubView = {
		image = {
			"asset/ui/club_new_newRes.png",
			"asset/anim/jinruzhuxianimage.png",
			"asset/ui/wordpeace_battleres4.png",
			"asset/ui/club_new_res2.png",
			"asset/ui/club_res.png",
			"asset/ui/club_newres.png",
			"asset/ui/rank_resRaw.png",
			"asset/ui/club_lang.png"
		}
	},
	CarnivalView = {
		image = {
			"asset/ui/carnRes.png",
			"asset/ui/common_heros.png"
		}
	},
	ShopView = {
		image = {
			"asset/ui/shop_res.png"
		}
	},
	ArenaNewView = {
		image = {
			"asset/ui/newArena_res.png",
			"asset/ui/arena_res.png"
		}
	},
	RecruitView = {
		image = {
			"asset/ui/recruit_res.png",
			"asset/anim/choukarenwuimage.png"
		}
	},
	CommonStageMainView = {
		image = {
			"asset/ui/block_res.png",
			"asset/anim/zhuxianrenwurukouimage.png",
			"asset/anim/zhangjiewenbenimage.png"
		}
	},
	WorldPeaceMainView = {
		image = {
			"asset/ui/wordpeace_res.png",
			"asset/anim/wordpeace_iconres.png",
			"asset/anim/wordpeace_battleres.png"
		}
	}
}
local __newLoadingWidgete

function AreanaNewLoadingModel:initialize()
	super.initialize(self)

	self._viewCache = {}
end

function AreanaNewLoadingModel:initSubviews(view)
	self._anim = cc.MovieClip:create("dh_jinruzhuxian")

	local director = cc.Director:getInstance()
	local scene = director:getRunningScene()
	local winSize = director:getWinSize()

	self._anim:setAnchorPoint(0.5, 0.5)
	self._anim:addTo(scene, 999999)
	self._anim:center(scene:getContentSize())
	self._anim:atExit(function()
		self._anim:removeAllChildren()

		__newLoadingWidgete = nil
	end)

	local layout = ccui.Layout:create()

	layout:setContentSize(cc.size(1386, 852))
	layout:setTouchEnabled(false)
	layout:setAnchorPoint(0.5, 0.5)
	layout:addTo(scene, 999999)
	layout:center(scene:getContentSize())

	self._touchLayout = layout

	self:hideAnim()
end

function AreanaNewLoadingModel:showAnim(callBack, info)
	info = info or {}

	if GameConfigs.closeAreaEnterAnim then
		if callBack then
			callBack()
		end

		return
	end

	if self._viewCache[info.viewName] and not info.forceShow then
		if callBack then
			callBack()
		end

		return
	end

	if info.viewName then
		self._viewCache[info.viewName] = 1
	end

	self:preloadRes(info)
	self._anim:setVisible(true)
	self._anim:gotoAndPlay(23)
	self._anim:addCallbackAtFrame(40, function(cid, mc)
		if callBack then
			callBack()
		end
	end)
	self._anim:addCallbackAtFrame(60, function(cid, mc)
		self:hideAnim()
	end)
	self._anim:setPlaySpeed(1.5)
	self._touchLayout:setTouchEnabled(true)
end

function AreanaNewLoadingModel:hideAnim()
	self._anim:stop()
	self._anim:setVisible(false)
	self._anim:clearCallbacks()
	self._touchLayout:setTouchEnabled(false)
end

function AreanaNewLoadingModel:clear()
	self._viewCache = {}
end

function AreanaNewLoadingModel:clearByName(name)
	self._viewCache[name] = nil
end

function AreanaNewLoadingModel.class:getInstance(view)
	if __newLoadingWidgete == nil then
		__newLoadingWidgete = AreanaNewLoadingModel:new()

		__newLoadingWidgete:initSubviews(view)
	end

	return __newLoadingWidgete
end

function AreanaNewLoadingModel:preloadRes(info)
	local config = preloadResConfig[info.viewName]

	if config then
		for type, list in pairs(config) do
			if type == "spine" then
				for i, modelId in pairs(list) do
					local roleModelInfo = ConfigReader:getRecordById("RoleModel", modelId)
					local spineName = string.format("asset/anim/%s.skel", roleModelInfo.Filename)

					AnimLoadUtils.asyncLoadSkeletonAnimation(spineName, function()
						return
					end)
				end
			elseif type == "image" then
				for i, fileName in pairs(list) do
					local textureCache = cc.Director:getInstance():getTextureCache()

					textureCache:addImageAsync(fileName, function()
						return
					end)
				end
			end
		end
	end
end
