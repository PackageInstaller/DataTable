-- chunkname: @modules/logic/summon/view/component/SummonFreeSingleGacha.lua

module("modules.logic.summon.view.component.SummonFreeSingleGacha", package.seeall)

local SummonFreeSingleGacha = class("SummonFreeSingleGacha", UserDataDispose)

function SummonFreeSingleGacha:ctor(singleSummonBtnGO, summonId)
	self:__onInit()

	self._btnSummonGO = singleSummonBtnGO
	self._btnSummonGroupGO = nil
	self._summonId = summonId
	self._canShowFree = SummonConfig.instance:canShowSingleFree(self._summonId)

	if not gohelper.isNil(self._btnSummonGO) and self._canShowFree then
		local parent = self._btnSummonGO.transform.parent

		if not gohelper.isNil(parent) and not gohelper.isNil(parent.parent) then
			self._btnSummonGroupGO = parent.gameObject

			local parentGO = parent.parent.gameObject

			gohelper.setActive(self._btnSummonGroupGO, false)

			self._prefabLoader = PrefabInstantiate.Create(parentGO)

			self._prefabLoader:startLoad(ResUrl.getSummonFreeButton(), self.handleInstanceLoaded, self)
		end
	end
end

function SummonFreeSingleGacha:dispose()
	logNormal("SummonFreeSingleGacha dispose : " .. tostring(self._summonId))

	if self._prefabLoader then
		self._prefabLoader:onDestroy()
	end

	if self._btnFreeSummon then
		self._btnFreeSummon:RemoveClickListener()
	end

	self:__onDispose()
end

function SummonFreeSingleGacha:handleInstanceLoaded()
	if self._prefabLoader and self._summonId then
		self._btnFreeSummonGO = self._prefabLoader:getInstGO()

		local siblingIndex = self._btnSummonGroupGO.transform:GetSiblingIndex()

		self._btnFreeSummonGO.transform:SetSiblingIndex(siblingIndex + 1)
		self:initButton()
		self:refreshUI()
	end
end

function SummonFreeSingleGacha:initButton()
	if self._btnFreeSummonGO then
		local x, y = recthelper.getAnchor(self._btnSummonGroupGO.transform)

		recthelper.setAnchor(self._btnFreeSummonGO.transform, x, y)

		self._gobtn = gohelper.findChild(self._btnFreeSummonGO, "#go_btn")
		self._gobanner = gohelper.findChild(self._btnFreeSummonGO, "#go_banner")
		self._txtbanner = gohelper.findChildText(self._btnFreeSummonGO, "#go_banner/#txt_banner")
		self._btnFreeSummon = gohelper.findChildButton(self._btnFreeSummonGO, "#go_btn/#btn_summonfree")

		self._btnFreeSummon:AddClickListener(self.onClickSummon, self)
		self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self.refreshOpenTime, self)
	end
end

function SummonFreeSingleGacha:onClickSummon()
	if self._summonId then
		logNormal("SummonFreeSingleGacha send summon 1")
		SummonMainController.instance:sendStartSummon(self._summonId, 1, false, true)
	end
end

function SummonFreeSingleGacha:refreshUI()
	if self._summonId and not gohelper.isNil(self._btnFreeSummonGO) and not gohelper.isNil(self._btnSummonGroupGO) then
		local summonMO = SummonMainModel.instance:getPoolServerMO(self._summonId)

		if summonMO.haveFree then
			self._needCountDown = false

			gohelper.setActive(self._btnFreeSummonGO, true)
			gohelper.setActive(self._btnSummonGroupGO, false)
			gohelper.setActive(self._gobtn, true)

			self._txtbanner.text = luaLang("summon_timelimit_free")
		else
			gohelper.setActive(self._gobtn, false)
			gohelper.setActive(self._btnSummonGroupGO, true)

			local poolCO = SummonConfig.instance:getSummonPool(self._summonId)

			if poolCO and summonMO.usedFreeCount < poolCO.totalFreeCount then
				self._needCountDown = true

				gohelper.setActive(self._btnFreeSummonGO, true)
			else
				self._needCountDown = false

				gohelper.setActive(self._btnFreeSummonGO, false)
			end
		end
	end

	self:refreshOpenTime()
end

function SummonFreeSingleGacha:refreshOpenTime()
	if self._needCountDown then
		local remainTime = ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal()
		local time, timeFormat = TimeUtil.secondToRoughTime2(remainTime)

		self._txtbanner.text = string.format(luaLang("summon_free_after_time"), tostring(time) .. tostring(timeFormat))
	end
end

return SummonFreeSingleGacha
