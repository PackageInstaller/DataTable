return {
	_rule_ = {
		none = {
			lattice_scroll_view = {
				path = "lattice_scroll_view",
				list = {
					viewport = {
						path = "lattice_scroll_view/viewport",
						list = {
							content = {
								path = "lattice_scroll_view/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"LatticeScrollRect",
					"UnityEngine.UI.Image"
				}
			}
		}
	}
}
