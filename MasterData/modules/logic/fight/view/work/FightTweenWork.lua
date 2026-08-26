-- chunkname: @modules/logic/fight/view/work/FightTweenWork.lua

module("modules.logic.fight.view.work.FightTweenWork", package.seeall)

local FightTweenWork = class("FightTweenWork", FightWorkItem)
local csTweenHelper = ZProj.TweenHelper

function FightTweenWork:onConstructor(param)
	self:setParam(param)
end

function FightTweenWork:setParam(param)
	self.param = param

	self:_ctorCheckParam()
end

function FightTweenWork:onStart()
	local tweenFunc = FightTweenWork.FuncDict[self.param.type]

	if tweenFunc then
		self._tweenId = tweenFunc(self, self.param)

		self:cancelFightWorkSafeTimer()
	else
		logError("声明了一个不存在的动画类型" .. self.param.type)
		self:onDone(true)
	end
end

function FightTweenWork:clearWork()
	if self._tweenId then
		csTweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightTweenWork:_onTweenEnd()
	self:onDone(true)
end

function FightTweenWork:DOTweenFloat(param)
	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOTweenFloat(param.from, param.to, param.t, self._tweenFloatFrameCb, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:_tweenFloatFrameCb(value)
	if self.param and self.param.frameCb then
		if self.param.cbObj then
			self.param.frameCb(self.param.cbObj, value, self.param.param)
		else
			self.param.frameCb(value, self.param.param)
		end
	end
end

function FightTweenWork:DOAnchorPos(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPos(param.tr, param.tox, param.toy, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOAnchorPosX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPosX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOAnchorPosY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOAnchorPosY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOWidth(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOWidth(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOHeight(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOHeight(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOSizeDelta(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOSizeDelta(param.tr, param.tox, param.toy, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOMove(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMove(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOMoveX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMoveX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOMoveY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOMoveY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOLocalMove(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMove(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOLocalMoveX(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMoveX(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOLocalMoveY(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalMoveY(param.tr, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOScale(param)
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

function FightTweenWork:DORotate(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DORotate(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOLocalRotate(param)
	if self:_checkObjNil(param.tr) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOLocalRotate(param.tr, param.tox, param.toy, param.toz, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOFadeCanvasGroup(param)
	if self:_checkObjNil(param.go) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOFadeCanvasGroup(param.go, param.from or -1, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:DOFillAmount(param)
	if self:_checkObjNil(param.img) then
		return
	end

	local ease = EaseType.Str2Type(param.ease)

	return csTweenHelper.DOFillAmount(param.img, param.to, param.t, self._onTweenEnd, self, nil, ease)
end

function FightTweenWork:_checkObjNil(obj)
	return gohelper.isNil(obj)
end

FightTweenWork.FuncDict = {
	DOTweenFloat = FightTweenWork.DOTweenFloat,
	DOAnchorPos = FightTweenWork.DOAnchorPos,
	DOAnchorPosX = FightTweenWork.DOAnchorPosX,
	DOAnchorPosY = FightTweenWork.DOAnchorPosY,
	DOWidth = FightTweenWork.DOWidth,
	DOHeight = FightTweenWork.DOHeight,
	DOSizeDelta = FightTweenWork.DOSizeDelta,
	DOMove = FightTweenWork.DOMove,
	DOMoveX = FightTweenWork.DOMoveX,
	DOMoveY = FightTweenWork.DOMoveY,
	DOLocalMove = FightTweenWork.DOLocalMove,
	DOLocalMoveX = FightTweenWork.DOLocalMoveX,
	DOLocalMoveY = FightTweenWork.DOLocalMoveY,
	DOScale = FightTweenWork.DOScale,
	DORotate = FightTweenWork.DORotate,
	DOLocalRotate = FightTweenWork.DOLocalRotate,
	DOFadeCanvasGroup = FightTweenWork.DOFadeCanvasGroup,
	DOFillAmount = FightTweenWork.DOFillAmount
}

local TypeNumber = "number"
local TypeFunction = "function"
local TypeUserData = "userdata"
local TypeGO = "UnityEngine.GameObject"
local TypeTr = "UnityEngine.(.-)Transform"
local TypeImg = "UnityEngine.UI.Image"

FightTweenWork.CheckParamList = {
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

function FightTweenWork:_ctorCheckParam()
	local checkParamsList = FightTweenWork.CheckParamList[self.param.type]

	if not checkParamsList then
		logError("FightTweenWork check param not implement: " .. self.param.type)

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

function FightTweenWork:_checkOneParam(params)
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
			errorDesc = string.format("FightTweenWork param is nil: %s.%s", self.param.type, paramName)
		elseif typeStr == "userdata" then
			if gohelper.isNil(oneParam) then
				ok = false
				errorDesc = string.format("FightTweenWork userdata isNil: %s.%s", self.param.type, paramName)
			elseif not string.find(tostring(oneParam), csType) then
				ok = false
				errorDesc = string.format("FightTweenWork userdata type not match: %s.%s, expect %s but %s", self.param.type, paramName, csType, tostring(oneParam))

				logError(errorDesc)
			end
		elseif typeStr ~= paramType then
			ok = false
			errorDesc = string.format("FightTweenWork type not match: %s.%s, expect %s but %s", self.param.type, paramName, paramType, typeStr)
		end
	end

	return ok, errorDesc
end

return FightTweenWork
