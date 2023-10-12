import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  searchLink(){
    const searchTerm = this.element.value;
    
    get(`/search?link[search]=${searchTerm}`, {
      responseKind: "turbo-stream"
    })
  }
}