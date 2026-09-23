--跃升成功界面
function Awake()
	fade = ComUtil.GetCom(gameObject, "ActionFade")
	fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()	
	CSAPI.PlayUISound("ui_core_upgrade")
	
	--lv1
	local _num1 = RoleTool.GetLimitLv(data:GetCoreLv() - 1, data:GetQuality())
	local lv1 = string.format("<color=#ffc146>%s</color><color=#929296>/%s</color>", data:GetLv(), _num1)
	CSAPI.SetText(txtLv1, lv1)
	--lv2
	local _num2 = RoleTool.GetLimitLv(data:GetCoreLv(), data:GetQuality())
	local lv2 = string.format("<color=#ffc146>%s</color><color=#ffffff>/%s</color>", data:GetLv(), _num2)
	CSAPI.SetText(txtLv2, lv2)
	
	--max
	local coreLv = RoleTool.GetMaxCoreLv(data:GetQuality())
	local cfg = Cfgs.CfgCardCoreLv:GetByID(data:GetQuality())
	local maxLv = cfg.infos[coreLv].limitLv
	CSAPI.SetText(txtMax, string.format("【MAX：%s】", maxLv))
end


function OnClickMask()	
	if not isCanBack then
		return
	end
	fade:Play(1, 0, 167, 0, function()
		view:Close()		
	end)
end 

function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end