-- chunkname: @modules/logic/survival/view/map/comp/SurvivalFlashTxtComp.lua

module("modules.logic.survival.view.map.comp.SurvivalFlashTxtComp", package.seeall)

local SurvivalFlashTxtComp = class("SurvivalFlashTxtComp", LuaCompBase)

function SurvivalFlashTxtComp:init(go)
	self._txt = gohelper.findChildTextMesh(go, "")
end

function SurvivalFlashTxtComp:setNormalTxt(txt)
	self._normalTxt = txt

	if not self._flashTxt then
		self._txt.text = txt
	end
end

function SurvivalFlashTxtComp:setFlashTxt(txt)
	self._flashTxt = txt

	if txt then
		if self.isShowFlashTxt then
			self._txt.text = self._flashTxt
		end

		TaskDispatcher.runRepeat(self._autoFlashTxt, self, 2)
	else
		TaskDispatcher.cancelTask(self._autoFlashTxt, self)
		TaskDispatcher.cancelTask(self._autoFlashTxt2, self)
		ZProj.TweenHelper.KillByObj(self._txt)

		local color = self._txt.color

		color.a = 1
		self._txt.color = color
		self.isShowFlashTxt = false
		self._txt.text = self._normalTxt
	end
end

function SurvivalFlashTxtComp:_autoFlashTxt()
	if not self._txt then
		TaskDispatcher.cancelTask(self._autoFlashTxt, self)

		return
	end

	ZProj.TweenHelper.DoFade(self._txt, 1, 0, 0.4)
	TaskDispatcher.runDelay(self._autoFlashTxt2, self, 0.4)
end

function SurvivalFlashTxtComp:_autoFlashTxt2()
	if not self._txt then
		return
	end

	self.isShowFlashTxt = not self.isShowFlashTxt
	self._txt.text = self.isShowFlashTxt and self._flashTxt or self._normalTxt

	ZProj.TweenHelper.DoFade(self._txt, 0, 1, 0.4)
end

function SurvivalFlashTxtComp:onDestroy()
	TaskDispatcher.cancelTask(self._autoFlashTxt, self)
	TaskDispatcher.cancelTask(self._autoFlashTxt2, self)
	ZProj.TweenHelper.KillByObj(self._txt)
end

return SurvivalFlashTxtComp
