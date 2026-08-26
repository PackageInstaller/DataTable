-- chunkname: @modules/logic/fight/view/work/TweenWork.lua

module("modules.logic.fight.view.work.TweenWork", package.seeall)

local TweenWork = class("TweenWork", BaseWork)
local csTweenHelper = ZProj.TweenHelper

function TweenWork:ctor(param)
	self:setParam(param)
end

function TweenWork:setParam(param)
	self.param = param

	self:_ctorCheckParam()
end

function TweenWork:onStart()
	local tweenFunc = TweenWork.FuncDict[self.param.type]

	if tweenFunc then
		self._tweenId = tweenFunc(self, self.param)
	else
		logError("tween tweenFunc not implement: " .. self.param.type)
		self:onDone(false)
	end
end

function TweenWork:clearWork()
	if self._tweenId then
		csTweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function TweenWork:_onTweenEnd()
	self:onDone(true)
end

function TweenWork:DOTweenFloat(param)
	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOTweenFloat(param.from, param.to, param.t, self._tweenFloatFrameCb, self._onTweenEnd, self, nil, ease)
end

function TweenWork:_tweenFloatFrameCb(value)
	if self.param and self.param.frameCb then
		if self.param.cbObj then
			self.param.frameCb(self.param.cbObj, value, self.param.param)
		else
			self.param.frameCb(value, self.param.param)
		end
	end
end

function TweenWork:DOAnchorPos(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPos(param.tr, param.tox, param.toy, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOAnchorPosX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPosX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOAnchorPosY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPosY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOWidth(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOWidth(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOHeight(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOHeight(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOSizeDelta(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOSizeDelta(param.tr, param.tox, param.toy, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOMove(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMove(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOMoveX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMoveX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOMoveY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMoveY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOLocalMove(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMove(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOLocalMoveX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMoveX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOLocalMoveY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMoveY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOScale(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)
	local scalex, scaley, scalez = param.tox, param.toy, param.toz

	if param.to then
		scalez = param.to
		scaley = param.to
		scalex = param.to
	end

	return csTweenHelper.DOScale(param.tr, scalex, scaley, scalez, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DORotate(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DORotate(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOLocalRotate(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalRotate(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOFadeCanvasGroup(param)
	if self:_checkObjNil(param.go) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOFadeCanvasGroup(param.go, param.from or -1, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:DOFillAmount(param)
	if self:_checkObjNil(param.img) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOFillAmount(param.img, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function TweenWork:_checkObjNil(obj)
	return gohelper.isNil(obj)
end

TweenWork.FuncDict = {
	DOTweenFloat = TweenWork.DOTweenFloat,
	DOAnchorPos = TweenWork.DOAnchorPos,
	DOAnchorPosX = TweenWork.DOAnchorPosX,
	DOAnchorPosY = TweenWork.DOAnchorPosY,
	DOWidth = TweenWork.DOWidth,
	DOHeight = TweenWork.DOHeight,
	DOSizeDelta = TweenWork.DOSizeDelta,
	DOMove = TweenWork.DOMove,
	DOMoveX = TweenWork.DOMoveX,
	DOMoveY = TweenWork.DOMoveY,
	DOLocalMove = TweenWork.DOLocalMove,
	DOLocalMoveX = TweenWork.DOLocalMoveX,
	DOLocalMoveY = TweenWork.DOLocalMoveY,
	DOScale = TweenWork.DOScale,
	DORotate = TweenWork.DORotate,
	DOLocalRotate = TweenWork.DOLocalRotate,
	DOFadeCanvasGroup = TweenWork.DOFadeCanvasGroup,
	DOFillAmount = TweenWork.DOFillAmount
}

local TypeNumber = "number"
local TypeFunction = "function"
local TypeUserData = "userdata"
local TypeGO = "UnityEngine.GameObject"
local TypeTr = "UnityEngine.(.-)Transform"
local TypeImg = "UnityEngine.UI.Image"

TweenWork.CheckParamList = {
	DOTweenFloat = {
		{
			{
				"from",
				TypeNumber
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			},
			{
				"frameCb",
				TypeFunction
			}
		}
	},
	DOAnchorPos = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOAnchorPosX = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOAnchorPosY = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOWidth = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOHeight = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOSizeDelta = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOMove = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"toz",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOMoveX = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOMoveY = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOLocalMove = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"toz",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOLocalMoveX = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOLocalMoveY = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DORotate = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"toz",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOLocalRotate = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"toz",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOFadeCanvasGroup = {
		{
			{
				"go",
				TypeUserData,
				TypeGO
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOFillAmount = {
		{
			{
				"img",
				TypeUserData,
				TypeImg
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	},
	DOScale = {
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"tox",
				TypeNumber
			},
			{
				"toy",
				TypeNumber
			},
			{
				"toz",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		},
		{
			{
				"tr",
				TypeUserData,
				TypeTr
			},
			{
				"to",
				TypeNumber
			},
			{
				"t",
				TypeNumber
			}
		}
	}
}

function TweenWork:_ctorCheckParam()
	local checkParamsList = TweenWork.CheckParamList[self.param.type]

	if not checkParamsList then
		logError("TweenWork check param not implement: " .. self.param.type)

		return
	end

	local errorDesc

	for _, params in ipairs(checkParamsList) do
		local var_26_0, var_26_1 = self:_checkOneParam(params)

		errorDesc = var_26_1

		if var_26_0 then
			return
		end
	end

	logError(errorDesc)
end

function TweenWork:_checkOneParam(params)
	local ok = true
	local errorDesc

	for _, paramNameType in ipairs(params) do
		local paramName = paramNameType[1]
		local paramType = paramNameType[2]
		local csType = paramNameType[3]
		local oneParam = self.param[paramName]
		local typeStr = type(oneParam)

		if oneParam == nil then
			ok = false
			errorDesc = string.format("TweenWork param is nil: %s.%s", self.param.type, paramName)
		elseif typeStr == "userdata" then
			if gohelper.isNil(oneParam) then
				ok = false
				errorDesc = string.format("TweenWork userdata isNil: %s.%s", self.param.type, paramName)
			elseif not string.find(tostring(oneParam), csType) then
				ok = false
				errorDesc = string.format("TweenWork userdata type not match: %s.%s, expect %s but %s", self.param.type, paramName, csType, tostring(oneParam))

				logError(errorDesc)
			end
		elseif typeStr ~= paramType then
			ok = false
			errorDesc = string.format("TweenWork type not match: %s.%s, expect %s but %s", self.param.type, paramName, paramType, typeStr)
		end
	end

	return ok, errorDesc
end

return TweenWork
