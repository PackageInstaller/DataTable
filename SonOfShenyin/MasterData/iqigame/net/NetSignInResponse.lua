-- chunkname: @IQIGame\\Net\\NetSignInResponse.lua

function net_sign.notifySign(signPod)
	SignInModule.SignNotify(signPod)
end

function net_sign.signResult(code, signPOD, itemShowPODS)
	SignInModule.SignResult(signPOD, itemShowPODS)
end

function net_sign.buyMonthCardResult(code)
	SignInModule.BuyMonthCardResult()
end
