-- chunkname: @modules/logic/fight/view/cardeffect/FigthMasterCardRemoveEffect.lua

module("modules.logic.fight.view.cardeffect.FigthMasterCardRemoveEffect", package.seeall)

local FigthMasterCardRemoveEffect = class("FigthMasterCardRemoveEffect", BaseWork)
local pathList = {
	"ui/viewres/fight/ui_effect_wuduquan_a.prefab"
}

function FigthMasterCardRemoveEffect:onStart(context)
	self._loader = self._loader or LoaderComponent.New()

	self._loader:loadListAsset(pathList, self._onLoaded, self._onAllLoaded, self)
end

function FigthMasterCardRemoveEffect:_onLoaded()
	return
end

function FigthMasterCardRemoveEffect:_onAllLoaded()
	for i, v in ipairs(pathList) do
		local loader = self._loader:getAssetItem(v)

		if loader then
			local tarPrefab = loader:GetResource()

			if i == 1 then
				self.context.card:playAni(ViewAnim.FightCardWuDuQuan, UIAnimationName.Close)

				self._clonePrefab = gohelper.clone(tarPrefab, self.context.card.go)

				gohelper.onceAddComponent(self._clonePrefab, typeof(UnityEngine.Animator)):Play("close", 0, 0)
			end
		end
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.8 / FightModel.instance:getUISpeed())
end

function FigthMasterCardRemoveEffect:_delayDone()
	self:onDone(true)
end

function FigthMasterCardRemoveEffect:clearWork()
	local cardObj = self.context.card._forAnimGO

	if not gohelper.isNil(cardObj) then
		gohelper.onceAddComponent(cardObj, gohelper.Type_CanvasGroup).alpha = 1
	end

	if not gohelper.isNil(self._clonePrefab) then
		gohelper.destroy(self._clonePrefab)
	end

	gohelper.setActive(self.context.card.go, false)

	if self._loader then
		self._loader:releaseSelf()

		self._loader = nil
	end
end

return FigthMasterCardRemoveEffect
