

function Awake()
    txtMove=ComUtil.GetCom(targetDesc,"TextMove")
    textGradient=ComUtil.GetCom(txt_desc,"UITextGradient");
end

function Init(str,isComplete)
    CSAPI.SetText(txt_desc,str);
    --txtMove:SetMove();
    CSAPI.SetGOActive(tick,isComplete);
    textGradient.enabled=isComplete;
    if isComplete then
        CSAPI.SetTextColor(txt_desc,255,255,255,255);
    else
        CSAPI.SetTextColor(txt_desc,255,255,255,155);
    end
end

