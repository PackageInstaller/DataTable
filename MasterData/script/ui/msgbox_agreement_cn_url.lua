local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = UnityEngine.Vector2
local var_0_3 = {
	"https://static.253.com/chuanglan/flash-policy.html",
	"https://i.360.cn/reg/privacy",
	"https://web.4399.com/local/200810/22-1230.html",
	"https://dsfs.oppo.com/store/cn/app/files/privacy_android.html",
	"https://www.vivo.com.cn/about-vivo/privacy-policy",
	"https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/sdk-data-security-0000001050042177",
	"https://privacy.consumer.huawei.com/legal/jogs/privacy-statement.htm?code=CN&branchid=1&language=zh_Hans_CN",
	"https://devquickapp.gionee.com/help/page/id/4.html",
	"https://a.9game.cn/tpl/pc/app/private.html",
	"https://hd.lenovomm.com/activity01/privacy/index.html",
	"https://i.flyme.cn/privacy",
	"https://account.nubia.com/res/html/privacy.html",
	"https://privacy.mi.com/xiaomigame-sdk/zh_CN/",
	"https://privacy.qq.com/policy/tencent-privacypolicy",
	"https://www.youxifan.com/aboutUs/3",
	"https://www.youxifan.com/aboutUs/3",
	"https://www.bilibili.com/blackboard/privacy-h5.html",
	"https://www.d.cn/about/privacy.html",
	"https://www.samsung.com/cn/info/privacy/",
	"https://user.guopan.cn/conceal.html",
	"https://hd.huya.com/huyaDIYzt/6811/pc/index.html#diySetTab=1",
	"https://mumu.163.com/20211103/25905_983334.html",
	"https://uct.x7sy.com/tggame/privacy",
	"https://resource.smartisan.com/docs/smartisan_policy_cn.html",
	"https://activity.52tt.com/yy-act/rules/privacypolicyttmobile/",
	"https://wiki.connect.qq.com/qq%E4%BA%92%E8%81%94sdk%E9%9A%90%E7%A7%81%E4%BF%9D%E6%8A%A4%E5%A3%B0%E6%98%8E",
	"https://privacy.qq.com/",
	"https://www.taptap.com/privacy-policy",
	"https://render.alipay.com/p/c/k2cx0tg8",
	"https://privacy.qq.com/document/priview/fbd2c3f898df4c1c869925dd49d57827",
	"https://crashsight.qq.com/welcome#/policy",
	"http://msa-alliance.cn/col.jsp?id=120",
	"https://www.oceanengine.com/extra/legal",
	"https://e.qq.com/optout.html",
	"https://union.baidu.com/bqt/#/policies",
	"https://www.kuaishou.com/about/policy?tab=privacy",
	"https://e.uc.cn/sso/static/pages/hcsso.html",
	"https://www.appsflyer.com/trust/privacy/",
	"https://www.loveota.com/weiduan_privacy/",
	"https://privacy.qq.com/policy/tencent-privacypolicy",
	"https://dev.233leyuan.com/#/doc/50131",
	"https://agreement.itsec.hihonor.com/asm/agrFile/getHtmlFile?agrNo=1183&country=cn&branchId=0&langCode=zh-cn",
	"https://developer.hihonor.com/cn/doc/guides/101178"
}

gamecore.UILoader:define("msgbox_agreement_cn_url", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._all_url = var_0_3
		self._control.main.useragreement.content.rectTransform.anchoredPosition = var_0_2(0, -1063)
	end

	function arg_1_0:__set_agreement_info(arg_5_1)
		if not arg_5_1 or arg_5_1 == "" then
			log.print_r("地址为空")
		else
			self._control.webview:SetActive(true)

			if self._control.webview.main_bg and not self._control.webview.main_bg:Equals(nil) and not self._control.webview.main_bg.rectTransform:Equals(nil) then
				self._control.webview.main_bg.uniWebView.ReferenceRectTransform = self._control.webview.main_bg.rectTransform

				self._control.webview.main_bg:GetComponent("UniWebView"):Load(arg_5_1)
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_7_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_1:class("msgbox_agreement_cn_url")

	var_8_0:__initia_lize()

	return var_8_0
end

return var_0_0
