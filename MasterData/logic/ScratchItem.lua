-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchItem.lua

module("logic.extensions.scratch.view.ScratchItem", package.seeall)

local ScratchItem = class("ScratchItem")

function ScratchItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node")
	self._cover = goutil.findChild(go, "cover")
	self._bomb = goutil.findChild(go, "bomb")
	self._dig = goutil.findChild(go, "dig")
	self._effectGo = goutil.findChild(go, "effect")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")

	goutil.setActive(self._cover, false)
	goutil.setActive(self._bomb, false)
	goutil.setActive(self._dig, false)
end

function ScratchItem:init(index, data, view)
	self._index = index

	self._btnClick:AddClickListener(self._onBtnClick, self)

	self._data = data
	self._view = view

	MaterialMgr.resetAll(self._node)

	if self:_isCover() then
		goutil.setActive(self._cover, true)
		goutil.setActive(self._bomb, false)
		goutil.setActive(self._dig, false)
		goutil.setActive(self._btnClick.gameObject, true)
	else
		goutil.setActive(self._btnClick.gameObject, false)

		if data.prizeId == ScratchModel.ShiziBomb or data.prizeId == ScratchModel.JiugongBomb then
			goutil.setActive(self._cover, true)
			goutil.setActive(self._bomb, true)
			goutil.setActive(self._dig, false)
		else
			goutil.setActive(self._cover, false)
			goutil.setActive(self._bomb, false)
			goutil.setActive(self._dig, false)

			local prizeId
			local isBigPrize = data.prizeId == ScratchModel.FirstPrize
			local cfg = ScratchConfig.instance:getScratchPrizeCfg(data.planId, isBigPrize and ScratchModel.instance:getBigPrizeId() or data.prizeId, isBigPrize)

			if cfg then
				MaterialMgr.setCellByCfg(cfg.prize, self._node)
			end
		end
	end

	self:removeEffect()
end

function ScratchItem:reset()
	MaterialMgr.resetAll(self._node)
	self._btnClick:RemoveClickListener()

	self._data = nil
	self._view = nil

	self:removeEffect()
end

function ScratchItem:_onBtnClick()
	if self:_isCover() then
		ScratchController.instance:sendScratchDigReq(self._data.x, self._data.y)
		ScratchModel.instance:setRecentDigGrid(self._data.x, self._data.y)
	else
		FloatWordMgr.instance:show("已翻牌！")
	end
end

function ScratchItem:_isCover()
	return self._data.prizeId == 0
end

function ScratchItem:loadDigEffect()
	if not self._effectGo then
		return
	end

	local effect = UIEffectManager.instance:playEffectBrief(self._view, "fx_ui_baozangmiche/fx_shizigao_donghua.prefab", self._effectGo.transform, false)

	effect:setParent(self._view.mainGO.transform)
	effect:setScale(100)

	effect.hideEffWhileNotOnTop = false
end

function ScratchItem:loadBoomEffect1()
	if not self._effectGo then
		return
	end

	local effect = UIEffectManager.instance:playEffectBrief(self._view, "fx_ui_baozangmiche/fx_hit_peng.prefab", self._effectGo.transform, false)

	effect:setParent(self._view.mainGO.transform)
	effect:setScale(10)

	effect.hideEffWhileNotOnTop = false
end

function ScratchItem:loadBoomEffect2()
	if not self._effectGo then
		return
	end

	local effect = UIEffectManager.instance:playEffectBrief(self._view, "fx_ui_baozangmiche/fx_hit_huo.prefab", self._effectGo.transform, false)

	effect:setParent(self._view.mainGO.transform)
	effect:setScale(10)

	effect.hideEffWhileNotOnTop = false
end

function ScratchItem:removeEffect()
	return
end

return ScratchItem
