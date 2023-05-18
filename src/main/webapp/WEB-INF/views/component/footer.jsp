<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
</style>

<footer class="bg-dark text-light p-4">
    <div id="footer" class="footer-extra-width">

    </div>
</footer>
<script>
  const date = new Date();
  console.log(date);
  console.log(date.getFullYear());
  const footer = document.getElementById("footer");
  footer.innerHTML = "<p>&copy; " + date.getFullYear() + "&nbsp; GOODFOOD  All rights reserved. </p>";
</script>