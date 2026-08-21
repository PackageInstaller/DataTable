-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/impl/TextWaveEffectImpl.lua

module("logic.common.viewlib.uieffect.impl.TextWaveEffectImpl", package.seeall)

local M = class("TextWaveEffectImpl", UIEffectBase)

M.gameObject = nil
M._textGO = textGO
M._texts = nil

function M:_buildUI(mainGO)
	self.gameObject = mainGO
end

function M:_destroyUI()
	return
end

function M:setTextGO(textGO)
	self._textGO = textGO
end

function M:setText(text)
	goutil.clearChildren(self.gameObject)

	self._texts = {}

	local width = 0
	local texts = string.utf8split(text)

	for i, text in ipairs(texts) do
		local go = goutil.clone(self._textGO, tostring(i))

		go:SetActive(true)
		goutil.addChildToParent(go, self.gameObject)

		self._texts[i] = go:GetComponent(goutil.Type_UIText)
		self._texts[i].text = text
		width = width + self._texts[i].preferredWidth
	end

	local current = 0

	for _, text in ipairs(self._texts) do
		local preferredWidth = text.preferredWidth

		Astral.TransformUtil.SetLocalPos(text.gameObject.transform, current + preferredWidth * 0.5 - width * 0.5, 0, 0)

		current = current + preferredWidth
	end
end

function M:setParams(duration, height, interval)
	self._duration = duration
	self._height = height
	self._interval = interval or 0
end

function M:play()
	local sequence = DG.Tweening.DOTween.Sequence()

	for i, text in ipairs(self._texts) do
		Astral.TransformUtil.SetLocalPosY(text.gameObject.transform, 0)

		if self._interval >= 0 then
			sequence:Append(text.gameObject.transform:DOLocalMoveY(self._height, self._duration, false):SetEase(DG.Tweening.Ease.InBack, 1):SetLoops(2, DG.Tweening.LoopType.Yoyo))

			if self._interval > 0 then
				sequence:AppendInterval(self._interval)
			end
		elseif i == 1 then
			sequence:Append(text.gameObject.transform:DOLocalMoveY(self._height, self._duration, false):SetEase(DG.Tweening.Ease.InBack, 1):SetLoops(2, DG.Tweening.LoopType.Yoyo))
		else
			sequence:Insert((i - 1) * (self._duration * 2 + self._interval), text.gameObject.transform:DOLocalMoveY(self._height, self._duration, false):SetEase(DG.Tweening.Ease.InBack, 1):SetLoops(2, DG.Tweening.LoopType.Yoyo))
		end
	end

	sequence:SetLoops(-1, DG.Tweening.LoopType.Restart)
	sequence:SetTarget(self.gameObject)
end

function M:stop()
	DG.Tweening.DOTween.Kill(self.gameObject)
end

return M
