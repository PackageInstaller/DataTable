-- chunkname: @modules/logic/fight/view/cardeffect/FigthMasterAddHandCardEffect.lua

module("modules.logic.fight.view.cardeffect.FigthMasterAddHandCardEffect", package.seeall)

local FigthMasterAddHandCardEffect = class("FigthMasterAddHandCardEffect", BaseWork)
local pathList = {
	"ui/viewres/fight/ui_effect_wuduquan_a.prefab"
}

function FigthMasterAddHandCardEffect:onStart(context)
	gohelper.setActive(self.context.card.go, false)

	self._loader = self._loader or LoaderComponent.New()

	self._loader:loadListAsset(pathList, self._onLoaded, self._onAllLoaded, self)
end

function FigthMasterAddHandCardEffect:_onLoaded()
	return
end

function FigthMasterAddHandCardEffect:_onAllLoaded()
	gohelper.setActive(self.context.card.go, true)

	for i, v in ipairs(pathList) do
		local loader = self._loader:getAssetItem(v)

		if loader then
			local tarPrefab = loader:GetResource()

			if i == 1 then
				self.context.card:playAni(ViewAnim.FightCardWuDuQuan)

				self._clonePrefab = gohelper.clone(tarPrefab, self.context.card.go)

				gohelper.onceAddComponent(self._clonePrefab, typeof(UnityEngine.Animator)):Play("open", 0, 0)
			end
		end
	end

	TaskDispatcher.runDelay(self._delayDone, self, 1.1 / FightModel.instance:getUISpeed())
end

function FigthMasterAddHandCardEffect:_delayDone()
	self:onDone(true)
end

function FigthMasterAddHandCardEffect:clearWork()
	if not gohelper.isNil(self._clonePrefab) then
		gohelper.destroy(self._clonePrefab)
	end

	if self._loader then
		self._loader:releaseSelf()

		self._loader = nil
	end
end

return FigthMasterAddHandCardEffect
