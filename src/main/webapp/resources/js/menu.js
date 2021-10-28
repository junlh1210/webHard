
const makeMenu_0 = (result) => {
	$('#menuName1').text(result[0].MENU_NM);
	
	for(let i=1 ; i < result.length; i++) {
		$('#board>div').append(`
			<a class="collapse-item">
                <span
                  onClick="javascript:showLoad('${result[i].MENU_NM}', '${result[i].BOARD_PATH}');"
                  style="cursor: pointer; cursor: hand"
                >
                  <i class="fas fa-list"></i>&nbsp;&nbsp;${result[i].MENU_NM}
                </span>
              </a>
		`);
	}
};
			
			
	const makeMenuArray = results => {
        const menuArray = [];
        let temp = [];
        for(let i = 0; i < results.length; i++) {
            if (results[i].LEVEL == 1 && temp.length != 0) {
                menuArray.push(temp);
                temp = [];
            }
            temp.push(results[i]);
        }
        menuArray.push(temp);

        return menuArray;
    };

    const makeMenu = menuArray => {
        let liStart = `
        <hr class="sidebar-divider my-0" />
    
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#${menuArray[0].PATH.substring(1)}"
            aria-expanded="true"
            aria-controls="${menuArray[0].PATH.substring(1)}"
          >
            ${menuArray[0].ICON_NM}
            <span>${menuArray[0].MENU_NM}</span>
          </a>
          <div id="${menuArray[0].PATH.substring(1)}" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
        `;

        for(let i=1 ; i < menuArray.length; i++) {
		    liStart += `
		      <a class="collapse-item">
                <span
                  onClick="javascript:showLoad('${menuArray[i].MENU_NM}', '${menuArray[i].PATH.startsWith('/board')  ? menuArray[i].PATH + '/1' :  menuArray[i].PATH}');"
                  style="cursor: pointer; cursor: hand"
                >
                  ${menuArray[i].ICON_NM}&nbsp;&nbsp;${menuArray[i].MENU_NM}
                </span>
              </a>
		    `;
	}

        let liEnd = `
            </div>
          </div>
        </li>
        `;

        return liStart + liEnd;
    };