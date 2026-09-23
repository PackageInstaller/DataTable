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
	local oldHot = data[1]
	local cur = PlayerClient:Hot()
	local max1, max2 = PlayerClient:MaxHot()
	
	CSAPI.SetText(txtHot1, "<color=#ffffff>" .. oldHot .. "</color><color=#929296>/" .. max1 .. "</color>")
	CSAPI.SetText(txtHot2, "<color=#ffc146>" .. cur .. "</color><color=#929296>/" .. max1 .. "</color>")
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