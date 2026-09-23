
function Awake()

    OnInitUI();
end
function OnInitUI()
    CSAPI.SetText(Title_txt,LanguageMgr:GetTips(1039));
    CSAPI.SetText(Content_txt,LanguageMgr:GetTips(1040));
end

function OnClickGotobtn()
    ShiryuSDK.RateUs();
    OnClickCloseBtn()
end
function OnClickCloseBtn()
       view:Close()
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
       OnClickCloseBtn();
end

function OnDestroy()


end